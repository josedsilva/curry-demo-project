<?php

class Project_Module_CompanyByCity extends Curry_Module
{
    public function toTwig()
    {
        $r = $this->getRequest();
        if (! ($r->hasParam('object_id') && $r->hasParam('object_class'))) {
            throw new Exception('Invalid query parameters.');
        }
        
        $q = CompanyQuery::create();
        if ($r->getParam('object_class') == 'Company') {
            // Propel queries are immutable.
            // You do this $q = $q->... for mutable queries (e.g. SilverStripe CMS)
            $q->filterByCompanyId($r->getParam('object_id'));
        } elseif ($r->getParam('object_class') == 'City') {
            $q->filterByCityId($r->getParam('object_id'));
        }
        
        return array(
            'q' => $q,
        );
    }
}