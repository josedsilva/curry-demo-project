<?php
/**
 * Quotes module built on the Silva framework.
 * We extend `Silva_Backend` instead of `Curry_Backend`
 * and register our views.
 *
 */
class Project_Backend_QuotesSilva extends Silva_Backend
{
    const BATCH_MAIL_COUNT = 25;
    
    public static function getGroup()
    {
        return 'Demo Flexigrid';
    }
    
    public function __construct()
    {
        parent::__construct();
        // Here we register our views.
        // For memory conservation, no grid is created when instantiating the Silva_View object.
        // The grid is constructed once per object when it is about to be rendered.
        $this->setViews(array(
            // The "tidyGrid" option smartly replaces foreign key columns with the relations'
            // "primaryString" columns.
            new Silva_View_Grid('Quote', null, $this, array('tidyGrid' => true)),
            $this->getCompanyAgreementsView(),
        ));
    }
    
    protected function getCompanyAgreementsView()
    {
        $vw = new Silva_View_Grid('QuoteCompany', 'Quote', $this, array('tidyGrid' => true));
        // Silva automatically creates breadcrumbs for your views.
        // By default, it uses the viewname for the breadcrumb text.
        $vw->setBreadcrumbText('Company agreements');
        return $vw;
    }
    
    /**
     * Manipulate the Quotes grid.
     * This is a callback function or a hook called by Silva
     * when the grid is about to be rendered.
     * It allows you to further manipulate the grid before rendering it.
     * The `getGrid` method returns the grid by reference.
     * @param Silva_View $vw
     */
    public function onQuoteGridInit(Silva_View $vw)
    {
        // buttons in Flexigrid are the same things as "actions" in ModelView.
        $buttons = array(
            Silva_View::BUTTON_AED,
            Silva_View::BUTTON_SEPARATOR,
            array(
                'caption' => 'Agreements',
                'url' => url('', array('module', 'view' => 'MainQuoteCompanys')),
                'forcePrimaryKey' => 1,
                'buttonOptions' => array(
                    'title' => 'Companies that made agreements for this quote',
                ),
            ),
            array(
                'caption' => 'Mail',
                // @see http://famfamfam.com/lab/icons/silk/previews/index_abc.png
                'bclass' => 'email',
                'url' => url('', array('module', 'view' => 'MainSendQuoteEmail')),
                'forcePrimaryKey' => 1,
                'buttonOptions' => array(
                    'title' => 'Send quote mail',
                ),
            ),
        );
        $grid = $vw->getGrid($buttons);
        $grid->setColumnOption(array('created_at', 'updated_at'), 'hide', true);
        $grid->moveColumn('heading', 0);
    }
    
    public function onQuoteCompanyGridInit(Silva_View $vw)
    {
        // no actions
        $buttons = array();
        $grid = $vw->getGrid($buttons);
        $grid->moveColumn('company', 0);
    }
    
    /**
     * This is an ordinary view. We will not show any flexigrid here.
     * Hence we do not register the view.
     */
    public function showMainSendQuoteEmail()
    {
        $this->addBreadcrumb('Quotes', url('', array('module', 'view' => 'Main')));
        $this->addBreadcrumb('QuoteEmail', url('', $_GET));
        
        // We want to pass these params to the callback JSON handler
        $params = array(
            'quote_id' => $_GET['quote_id'],
        );
        // Helper defined in Silva_Backend.
        // It is responsible for injecting the HTML/JS necessary to show the progress bar
        // and also initializes the Zend Session.
        $this->sendMail($params, 'QuoteMailBatchJson');
    }
    
    /**
     * The callback JSON handler.
     * The JS will callback this method by making an Ajax request.
     * @throws Exception
     */
    public function showQuoteMailBatchJson()
    {
        $page = isset($_GET['page']) ? $_GET['page'] : 1;
        $quote = QuoteQuery::create()->findPk($_GET['quote_id']);
        if (!$quote) {
            throw new Exception('quote not found');
        }
        
        // create a Propel pager for companies to avoid running
        // out of memory.
        $q = $this->getQueryFromQuote($quote);
        $companies = $q->paginate($page, self::BATCH_MAIL_COUNT);
        
        // helper defined in Silva_Backend
        // This function will loop over the companies collection and
        // pass each company object to the callback "sendCompanyMail".
        // Based on the return statuses of each call, it will calculate
        // update data to return to the progress bar.
        $json = parent::mailBatchJson($companies, 'sendCompanyMail');
        $this->returnJson($json);
    }
    
    public function sendCompanyMail(Company $company)
    {
        $sendMailStatus = false;
        $logMessage = null;
        $quote = QuoteQuery::create()->findPk($_GET['quote_id']);
        if (!$quote) {
            throw new Exception('quote not found');
        }
        
        try {
            $company->sendQuoteMail($quote);
            $sendMailStatus = true;
        } catch (Exception $e) {
            $sendMailStatus = false;
            $logMessage = "Exception while sending email: {$e->getMessage()}";
        }
        
        return array($sendMailStatus, $logMessage);
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