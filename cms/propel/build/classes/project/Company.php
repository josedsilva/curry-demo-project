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
class Company extends BaseCompany
{
    const QUOTE_MAIL_TPL_ID = 8;
    const BUY_QUOTE_PAGE_LINK = 'demo/buy-quote/';
    
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
                'qid' => $this->getPrimaryKey()
            ))->getAbsolute('&', true),
        );
        
        $mail = Curry_Mail::createFromPage($mailTpl, null, $globals);
        $mail->addTo($this->getClientEmail(), $this->getClientName());
        $mail->setFrom(Curry_Core::$config->curry->adminEmail, Curry_Core::$config->curry->projectName);
        $mail->setSubject($subject);
        try {
            $mail->send();
        } catch (Exception $e) {
            throw $e;
        }
    }
}
