<?php

class Project_Application extends Curry_Application
{
    public function __construct()
    {
        parent::__construct();
        $this->setupRoutes();
    }
    
    /**
     * TODO: Setup your custom routes here.
     */
    protected function setupRoutes()
    {
        $this->addRoute(new Project_CityOrCompanyRoute());
    }

}
