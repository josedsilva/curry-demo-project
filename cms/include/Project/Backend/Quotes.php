<?php

class Project_Backend_Quotes extends Curry_Backend
{
    const BATCH_MAIL_COUNT = 25;
    
    public static function getGroup()
    {
        return 'Demo ModelView';
    }
    
    public function showMain()
    {
        $mf = new Curry_Form_ModelForm('Quote', array(
            'withRelations' => array('RecyclingType', 'ClientCity'),
            'columnElements' => array(
                // remove form element
                'created_at' => false,
                // remove form element
                'updated_at' => false,
                'relation__recyclingtype' => array('select', array(
                    'multiOptions' => array(null => '[ Select ]') + RecyclingTypeQuery::create()
                        ->orderByName()
                        ->find()
                        ->toKeyValue('PrimaryKey', 'Name'),
                    'required' => true,
                )),
                'relation__clientcity' => array('select', array(
                    'multiOptions' => array(null => '[ Select ]') + CityQuery::create()
                        ->orderByName()
                        ->find()
                        ->toKeyValue('PrimaryKey', 'Name'),
                    'required' => true,
                )),
            ),
        ));
        $list = new Curry_ModelView_List('Quote', array(
            'modelForm' => $mf,
            // hide group of list columns
            'hide' => array('client_email', 'client_telephone', 'created_at', 'updated_at'),
            'columns' => array(
                'heading' => array(
                    // always make this the first column
                    'order' => -1,
                    // attach the "edit" action to this column
                    'action' => 'edit',
                ),
            ),
            'actions' => array(
                'action_company_agreements' => array(
                    'label' => 'Company agreements',
                    'action' => $this->getCompanyList(),
                    'single' => true,
                    'class' => 'inline',
                ),
                'action_quote_mail' => array(
                    'label' => 'Send quote mail',
                    'href' => (string) url('', array('module', 'view' => 'QuoteMail')),
                    'single' => true,
                    'class' => 'inline',
                ),
            ),
        ));
        $list->show($this);
    }
    
    protected function getCompanyList()
    {
        $q = QuoteCompanyQuery::create()
            ->joinWithCompany();
        return new Curry_ModelView_List($q, array(
            'columns' => array(
                'company_id' => array(
                    'label' => 'Company Id',
                    'callback' => function($o)
                    {
                        return $o->getCompanyId();
                    },
                    'order' => 0,
                ),
                'company_name' => array(
                    'label' => 'CompanyName',
                    'callback' => function($o)
                    {
                        return $o->getCompany()->getName();
                    },
                    'order' => 1,
                ),
            ),
            'actions' => array(
                // we don't want to create a record through the backend.
                // This should happen from the front end.
                // Hide the "Create new" button.
                'new' => false,
                // do not delete this record
                'delete' => false,
                // do not edit this record
                'edit' => false,
            ),
        ));
    }
    
    public function showQuoteMail()
    {
        // the "item" query string parameter contains the foreign-key.
        // in our case the "quote_id" since the ModelViewList is showing rows from the "quote" table.
        $quoteId = $_GET['item'];
        $url = url('', array('module', 'view' => 'MailBatchJson', 'quote_id' => $quoteId));
        $html = <<<HTML
<script type="text/javascript">
// <![CDATA[
$(function() {
    $("#progressbar").progressbar({ value: 0 });
    var sendmail = function(data, textStatus) {
        $("#progressbar").progressbar('value', data.status);
        $('#mail-status').html('Sending emails, ' + data.eta + ' seconds remaining...<br />Sent: ' + data.sent + '<br/>Failed: ' + data.failed);
        
        if(data.url) {
            $.get(data.url, null, sendmail, 'json');
        } else {
            if(data.status == 100) {
                $('#mail-status').html('All done!<br />Sent: ' + data.sent + '<br/>Failed: ' + data.failed);
            } else {
                $('#mail-status').append('<br />Error');
            }
        }
    };
    $.get("{$url}", null, sendmail, 'json');
});
// ]]>
</script>
<p>
    <div id="progressbar"></div>
</p>
<br/>
<p id="mail-status">
    Please wait, preparing...
</p>
HTML;
    
        $session = new Zend_Session_Namespace(__CLASS__);
        $session->sent = 0;
        $session->failed = 0;
        $session->startTime = microtime(true);
        
        $this->addMainContent($html);
    }
    
    public function showMailBatchJson()
    {
        $session = new Zend_Session_Namespace(__CLASS__);
        $sent = (int) $session->sent;
        $failed = (int) $session->failed;
        $startTime = $session->startTime;
        
        $quote = QuoteQuery::create()->findPk($_GET['quote_id']);
        if (!$quote) {
            throw new Exception('quote not found');
        }
        
        $c = $this->getQueryFromQuote($quote);
        $page = isset($_GET['page']) ? $_GET['page'] : 1;
        $companies = $c->paginate($page, self::BATCH_MAIL_COUNT);
        
        // send mail
        foreach ($companies as $company) {
            try {
                // send mail: method defined in the Company propel class
                $company->sendQuoteMail($quote);
                ++ $sent;
            } catch (Exception $e) {
                Curry_Core::log('Failed to send to ' . $company->getEmail() . ': ' . $e->getMessage(), Zend_Log::ERR);
                ++ $failed;
            }
        }
        
        $session->sent = $sent;
        $session->failed = $failed;

        $totalSent = $sent + $failed;
        $elapsedTime = microtime(true) - $startTime;
        $mailsPerSecond = $totalSent / $elapsedTime;
        $remainingMails = $companies->getNbResults() - $totalSent;
        $eta = $mailsPerSecond > 0 ? $remainingMails / $mailsPerSecond : 1;
        
        $json = array(
            'status' => $companies->getLastPage() ? round($companies->getPage() * 100 / $companies->getLastPage()) : 100,
            'eta' => round($eta),
            'sent' => $sent,
            'failed' => $failed
        );
        
        // do we have more pages?
        if ($companies->getLastPage() && !$companies->isLastPage()) {
            // update the "page" query parameter to fetch the next batch.
            $json['url'] = (string) url('', $_GET)->add(array('page' => $companies->getNextPage()));
        }
        else {
            // no more companies to send email to.
            if ($sent) {
                // update quote status
                $quote->setStatus('sent');
                $quote->save();
            }
        }
        
        $this->returnJson($json);
    }
    
    protected function getQueryFromQuote(Quote $quote)
    {
        $q = CompanyQuery::create()
            // company city matches city of quote owner
            ->filterByCityId($quote->getClientCityId())
            ->useCoRtQuery(null, Criteria::LEFT_JOIN)
                // one of company's Rt match Rt of quote
                ->filterByRecyclingTypeId($quote->getRecyclingTypeId())
            ->endUse();
        return $q;
    }
}