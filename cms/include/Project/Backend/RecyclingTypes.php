<?php

class Project_Backend_RecyclingTypes extends Curry_Backend
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
        $list = new Curry_ModelView_List('RecyclingType');
        
        $list->show($this);
    }
    
}