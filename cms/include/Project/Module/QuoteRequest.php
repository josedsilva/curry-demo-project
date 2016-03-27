<?php

class Project_Module_QuoteRequest extends Curry_Module
{
    
    /* public function showFront(Curry_Twig_Template $template = null)
    {
        $r = $this->getRequest();
        
        // TODO: front end code
        
        if (null !== $template) {
            return $template->render(array(
                
            ));
        }
    } */
    
    public function toTwig()
    {
        $r = $this->getRequest();
        $isSaved = false;
        
        $form = new Curry_Form_ModelForm('Quote', array(
            'class' => 'quote-request-form',
            'withRelations' => array('RecyclingType', 'City'),
            'columnElements' => array(
                'heading' => array('text', array(
                    'required' => true,
                )),
                'client_name' => array('text', array(
                    'required' => true,
                )),
                'client_email' => array('text', array(
                    'required' => true,
                )),
                'relation__recyclingtype' => array('select', array(
                    'multiOptions' => array(null => '[ Select ]') + RecyclingTypeQuery::create()
                        ->orderByName()
                        ->find()
                        ->toKeyValue('PrimaryKey', 'Name'),
                    'required' => true,
                )),
                'relation__city' => array('select', array(
                    'multiOptions' => array(null => '[ Select ]') + CityQuery::create()
                        ->orderByName()
                        ->find()
                        ->toKeyValue('PrimaryKey', 'Name'),
                    'required' => true,
                )),
                'created_at' => false,
                'updated_at' => false,
                'status' => false,
            ),
        ));
        $form->addElement('submit', 'save', array('label' => 'Submit'));
        
        if ($r->isPost() && $form->isValid($r->post)) {
            $quote = new Quote();
            $form->fillModel($quote);
            $quote->save();
            $isSaved = true;
        }
        return array(
            'form' => $form,
            'is_saved' => $isSaved,
        );
    }
    
    public function showBack()
    {
        return new Curry_Form_SubForm(array(
            'elements' => array(
                
            ),
        ));
    }
    
    public function saveBack(Zend_Form_SubForm $form)
    {
        $values = $form->getValues(true);
    }
}