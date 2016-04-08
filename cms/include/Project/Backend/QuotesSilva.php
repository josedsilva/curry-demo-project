<?php

class Project_Backend_QuotesSilva extends Silva_Backend
{
    public static function getGroup()
    {
        return 'Demo Flexigrid';
    }
    
    public function __construct()
    {
        parent::__construct();
        $this->setViews(array(
            new Silva_View_Grid('Quote', null, $this),
        ));
    }
}