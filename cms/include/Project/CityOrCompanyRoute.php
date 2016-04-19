<?php

class Project_CityOrCompanyRoute implements Curry_IRoute
{
    public function route(Curry_Request $request)
    {
        $path = $request->getUrl()->getPath();
        // URL of the placeholder page.
        $base = 'demo/customroute/';
        $m = array();
        if (preg_match('@^'.preg_quote($base, '@').'([^/]+)/$@', $path, $m)) {
            $slug = $m[1];
            try {
                // Check whether the slug exists in either the "city" or "company" table.
                // FIXME: this is something like a "Null coalescing" expression (php7 has ??)
                // FIXME: I will be glad if somebody tells me what this "ternary" expression is called.
                $o = CityQuery::create()->findOneBySlug($slug) ?: CompanyQuery::create()->findOneBySlug($slug);
                if ($o) {
                    // Add custom query params so that our module can identify them.
                    $request->setParam('get', 'object_id', $o->getPrimaryKey());
                    $request->setParam('get', 'object_class', get_class($o));
                    // we will "forward" to the same page as defined in $base
                    $next = $base;
                    $request->setUri($next);
                    // forward/route to the page.
                    return true;
                }
            } catch (Exception $e) {
                // TODO: Log exception
            }
        }
        // do not re-route
        return false;
    }
    
}