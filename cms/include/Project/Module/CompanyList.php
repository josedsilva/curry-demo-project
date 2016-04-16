<?php

class Project_Module_CompanyList extends Curry_Module
{
    public function toTwig()
    {
        $q = CompanyQuery::create('c')
            ->orderByName()
            ->leftJoinQuoteCompany('a')
            ->withColumn('COUNT(a.CompanyId)', 'NbrAgreements')
            ->groupBy('c.CompanyId');
        
        return array(
            'query' => $q,
        );
    }
}