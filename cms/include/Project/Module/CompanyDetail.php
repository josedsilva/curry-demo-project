<?php

class Project_Module_CompanyDetail extends Curry_Module
{

    public function toTwig()
    {
        $r = $this->getRequest();
        if (!$r->hasParam('company_id')) {
            throw new Exception('Company not found');
        }
        
        $q = CompanyQuery::create()
            ->filterByCompanyId($r->getParam('company_id'));
        
        // Do you know why I am not passing a model instance but instead
        // passing a ModelCriteria object? I explained this in a previous chapter.
        return array(
            'q' => $q
        );
    }
    
}