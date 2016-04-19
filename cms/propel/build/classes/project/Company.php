<?php



/**
 * Skeleton subclass for representing a row from the 'company' table.
 *
 *
 *
 * You should add additional methods to this class to meet the
 * application requirements.  This class will only be generated as
 * long as it does not already exist in the output directory.
 *
 * @package    propel.generator.project
 */
class Company extends BaseCompany implements Curry_ISearchable
{
    const QUOTE_MAIL_TPL_ID = 8;
    const BUY_QUOTE_PAGE_LINK = 'demo/buy-quote/';
    
    public function toTwig()
    {
        $ret = array_merge($this->toArray(), $this->getVirtualColumns());
        $ret['PrimaryKey'] = $this->getPrimaryKey();
        $ret['AgreementQuotes'] = new Curry_OnDemand(array($this, 'getAgreementQuotes'));
        $ret['Body'] = new Curry_OnDemand(array($this, 'getBody'));
        
        return $ret;
    }
    
    /**
     * Return a document to index or null to
     * skip indexing this object.
     * @return Zend_Search_Lucene_Document
     */
    public function getSearchDocument()
    {
        $doc = new Zend_Search_Lucene_Document();
        $doc->addField(Zend_Search_Lucene_Field::Text('title', $this->getName()));
        // if we had some description field, we could use it here.
        $doc->addField(Zend_Search_Lucene_Field::Text('description', strip_tags($this->getName())));
        $doc->addField(Zend_Search_Lucene_Field::Text('body', strip_tags($this->getBody())));
        $doc->addField(Zend_Search_Lucene_Field::Keyword('url', $this->getUrl()));
        return $doc;
    }
    
    public function getBody()
    {
        $html=<<<HTML
<p>Company Name: {$this->getName()}<br />
Org Nbr: {$this->getOrgNumber()}<br />
City: {$this->getCity()->getName()}<br />
Recycling types: {$this->getRecyclingTypeList()}</p>
HTML;
        return $html;
    }
    
    public function getRecyclingTypeList()
    {
        $list = RecyclingTypeQuery::create()
            ->useCoRtQuery()
                ->filterByCompany($this)
            ->endUse()
            ->find()
            ->toKeyValue('PrimaryKey', 'Name');
        
        return implode(', ', $list);
    }
    
    public function getUrl()
    {
        return 'demo/company/'.$this->getSlug().'/';
    }
    
    public function getAgreementQuotes()
    {
        return QuoteQuery::create('q')
            ->useQuoteCompanyQuery()
                ->filterByCompany($this)
            ->endUse()
            ->find();
    }
    
    public function sendQuoteMail(Quote $quote, $subject = 'New quote request')
    {
        $mailTpl = PageQuery::create()->findPk(self::QUOTE_MAIL_TPL_ID);
        if (!$mailTpl) {
            throw new Exception('Cannot find mail template page.');
        }
        
        $globals = array(
            'company' => $this,
            'quote' => $quote,
            'buy_quote_link' => url(self::BUY_QUOTE_PAGE_LINK, array(
                // identify the company
                'cid' => $this->getPrimaryKey(),
                // identify the quote
                'qid' => $quote->getPrimaryKey(),
            ))->getAbsolute('&', true),
        );
        
        $mail = Curry_Mail::createFromPage($mailTpl, null, $globals);
        $mail->addTo($this->getEmail(), $this->getContactPerson());
        $mail->setFrom(Curry_Core::$config->curry->adminEmail, Curry_Core::$config->curry->projectName);
        $mail->setSubject($subject);
        try {
            $mail->send();
        } catch (Exception $e) {
            throw $e;
        }
    }
}
