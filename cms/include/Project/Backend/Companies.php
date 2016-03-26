<?php

class Project_Backend_Companies extends Curry_Backend
{
    /**
     * Create a group icon in the Admin module panel
     * and make this module available in the specified group.
     * @return string
     */
    public static function getGroup()
    {
        return 'Demo ModelView';
    }
    
    /**
     * The method called by default by the cms.
     * Something similar to C program - or rather the first function called.
     */
    public function showMain()
    {
        $q = CompanyQuery::create('c')
            ->leftJoinCoRt('cr')
            ->withColumn('COUNT(cr.RecyclingTypeId)', 'NbrRt')
            ->groupBy('cr.CompanyId');
        $list = new Curry_ModelView_List($q, array(
            'columns' => array(
                'NbrRt' => array(
                    // assign action to this column item.
                    'action' => 'action_recycling_types',
                ),
            ),
            'actions' => array(
                // override the default 'edit' action options
                'edit' => array(
                    // show view in popup
                    'class' => 'dialog',
                ),
                // create a custom action
                'action_recycling_types' => array(
                    'label' => 'Recycling types',
                    'action' => $this->getRecyclingTypesList(),
                    'single' => true,
                    // show nested view
                    'class' => 'inline',
                ),
            ),
        ));
        $list->show($this);
    }
    
    public function getRecyclingTypesList()
    {
        $mf = new Curry_Form_ModelForm('CoRt', array(
            'withRelations' => array('RecyclingType'),
            'columnElements' => array(
                'relation__recyclingtype' => array('select', array(
                    'multiOptions' => array(null => '[ Select ]') + RecyclingTypeQuery::create()
                        ->orderByName()
                        ->find()
                        ->toKeyValue('PrimaryKey', 'Name'),
                )),
            ),
        ));
        
        $q = CoRtQuery::create()
            ->joinWithRecyclingType();
        return new Curry_ModelView_List($q, array(
            'modelForm' => $mf,
            'columns' => array(
                // add custom field.
                'recycling_type_id' => array(
                    'label' => 'RT ID',
                    'callback' => function($o)
                    {
                        return $o->getRecyclingTypeId();
                    },
                ),
                // add custom field.
                'recycling_type_name' => array(
                    'label' => 'Recycling type name',
                    'callback' => function($o)
                    {
                        return $o->getRecyclingType()->getName();
                    },
                ),
            ),
        ));
    }
    
}