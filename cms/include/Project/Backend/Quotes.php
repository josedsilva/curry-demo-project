<?php

class Project_Backend_Quotes extends Curry_Backend
{
    public static function getGroup()
    {
        return 'Demo ModelView';
    }
    
    public function showMain()
    {
        $mf = new Curry_Form_ModelForm('Quote', array(
            'withRelations' => array('RecyclingType', 'ClientCity'),
            'columnElements' => array(
                'created_at' => false,
                'updated_at' => false,
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
                // cannot delete
                'delete' => false,
                // cannot edit
                'edit' => false,
            ),
        ));
    }
}