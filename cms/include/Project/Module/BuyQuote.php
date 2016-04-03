<?php

class Project_Module_BuyQuote extends Curry_Module
{
    
    public function toTwig()
    {
        if (!Curry_URL::validate()) {
            throw new Exception('URL validation failed. Parameters are manipulated externally.');
        }
        
        $r = $this->getRequest();
        $quote = QuoteQuery::create()->findPk($r->getParam('qid'));
        $company = CompanyQuery::create()->findPk($r->getParam('cid'));
        
        $form = new Curry_Form(array(
            'method' => 'post',
            'elements' => array(
                'chk_agree' => array('checkbox', array(
                    'label' => 'I agree to terms and conditions',
                )),
                'btn_buy' => array('submit', array('label' => 'Buy quote')),
            ),
        ));
        
        if ($r->isPost() && $form->isValid($r->post)) {
            if (!$form->chk_agree->isChecked()) {
                $form->chk_agree->addError('Please agree to Terms and Conditions.');
                $form->chk_agree->markAsError();
            } else {
                // TODO: update views
                $quote_company = new QuoteCompany();
                $quote_company->setQuoteId($quote->getPrimaryKey())
                    ->setCompanyId($company->getPrimaryKey())
                    ->save();
                
                return array(
                    'quote' => $quote,
                    'company' => $company,
                );
            }
        }
        
        return array(
            'form' => $form,
            'quote' => $quote,
            'company' => $company,
        );
    }
}