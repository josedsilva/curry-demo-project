<?php

class Project_Backend_QuotesFlex extends Curry_Backend
{
    public static function getGroup()
    {
        return 'Demo Flexigrid';
    }
    
    public static function getName()
    {
        return 'Quotes';
    }
    
    public function showMain()
    {
        $grid = $this->getQuotesGrid();
        
        if (isset($_GET['json'])) {
            Curry_Application::returnJson($grid->getJSON());
        }
        
        $this->addMainContent($grid->getHtml());
    }
    
    protected function getQuotesGrid()
    {
        $grid = new Curry_Flexigrid_Propel('Quote',
            url('', $_GET)->add(array('json' => 1)));
        
        $editUrl = url('', array('module', 'view' => 'Quote'));
        $grid->addAddButton($editUrl);
        $grid->addEditButton($editUrl);
        $grid->addDeleteButton();
        
        return $grid;
    }
    
    public function showQuote()
    {
        $quote = null;
        
        // Edit function
        if (isset($_GET['quote_id'])) {
            $quote = QuoteQuery::create()->findPk($_GET['quote_id']);
        }
        
        // Add function
        if (!$quote) {
            $quote = new Quote();
        }
        
        $form = $this->getQuoteForm($quote);
        if (isPost() && $form->isValid($_POST)) {
            $this->saveQuote($quote, $form);
            $this->returnPartial(''); // close the dialog-box
        }
        
        $this->returnPartial($form); // show form in the dialog-box
    }
    
    protected function getQuoteForm(Quote $quote)
    {
        $mf = new Curry_Form_ModelForm('Quote', array(
            // Unlike ModelView, we need to pass the PrimaryKey of the model-instance in the action for "Edit" to work.
            'action' => (string) url('', array('module', 'view', 'quote_id' => $quote->getPrimaryKey())),
            'withRelations' => array('RecyclingType', 'ClientCity'),
            'columnElements' => array(
                'created_at' => false,
                'updated_at' => false,
            ),
        ));
        $mf->addElement('submit', 'save', array('label' => 'Save'));
        $mf->fillForm($quote);
        return $mf;
    }
    
    protected function saveQuote(Quote $quote, Curry_Form_ModelForm $mf)
    {
        $mf->fillModel($quote);
        $quote->save();
    }
    
}