<?php 
/*
@author	Dmitriy Kubarev
@link	http://www.simpleopencart.com
@link	http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4811
*/  

include_once(DIR_SYSTEM . 'library/simple/simple_controller.php');

class ControllerCheckoutSimpleCheckoutPaymentAddress extends SimpleController {
    static $error = array();
    static $updated = false;

    private $_templateData = array();

    private function init() {
        $this->load->library('simple/simplecheckout');
        
        $this->simplecheckout = SimpleCheckout::getInstance($this->registry);
        $this->simplecheckout->setCurrentBlock('payment_address');

        $this->language->load('checkout/simplecheckout');
    }

    public function index() {
        if (!self::$updated) {
            $this->update();
        }

        $this->init();

        if ($this->simplecheckout->isBlockHidden()) {
            $this->simplecheckout->resetCurrentBlock();
            return;
        }

        $this->_templateData['text_checkout_payment_address'] = $this->language->get('text_checkout_payment_address');
        $this->_templateData['entry_address_same']            = $this->language->get('entry_address_same');
        
        $this->_templateData['display_address_same']          = $this->simplecheckout->displayAddressSame();
        $this->_templateData['address_same']                  = $this->simplecheckout->isAddressSame();

        $this->_templateData['rows']        = $this->simplecheckout->getRows();
        $this->_templateData['hidden_rows'] = $this->simplecheckout->getHiddenAddressRows();

        $this->validate();

        unset($this->session->data['simple']['registered']);

        $this->_templateData['display_header'] = $this->simplecheckout->getSettingValue('displayHeader');
        $this->_templateData['display_error']  = $this->simplecheckout->displayError();
        $this->_templateData['has_error']      = $this->simplecheckout->hasError();
        $this->_templateData['hide']           = $this->simplecheckout->isBlockHidden();
        
        $this->simplecheckout->resetCurrentBlock();

        $this->setOutputContent($this->renderPage('checkout/simplecheckout_payment_address.tpl', $this->_templateData));
    }

    public function update() {
        self::$updated = true;

        $this->init();

        if ($this->simplecheckout->isBlockHidden()) {
            $this->simplecheckout->resetCurrentBlock();
            return;
        }

        $this->simplecheckout->updateFields();

        $this->saveToSession();

        $this->simplecheckout->resetCurrentBlock();
    }

    public function saveToSession() {
        $version = $this->simplecheckout->getOpencartVersion();
        
        $address = $this->simplecheckout->getPaymentAddress();
        
        if (!$this->customer->isLogged() && !self::$error) {
            $this->session->data['guest']['payment'] = $address;
        }
        
        unset($this->session->data['payment_address_id']);  
        unset($this->session->data['payment_country_id']);  
        unset($this->session->data['payment_zone_id']); 
        
        if (!empty($address['address_id'])) {
            $this->session->data['payment_address_id'] = $address['address_id'];
        } 
        
        if (!empty($address['country_id'])) {
            $this->session->data['payment_country_id'] = $address['country_id'];
        } else {
            $this->session->data['payment_country_id'] = 0;
        }
        
        if (!empty($address['zone_id'])) {
            $this->session->data['payment_zone_id'] = $address['zone_id'];
        } else {
            $this->session->data['payment_zone_id'] = 0;
        }
        
        if ($version == 152 && !empty($this->session->data['guest']['payment']) && is_array($this->session->data['guest']['payment'])) {
            $clear = true;
            foreach ($this->session->data['guest']['payment'] as $key => $value) {
                if ($value) {
                    $clear = false;
                    break;
                }
            }
            if ($clear) {
                unset($this->session->data['guest']['payment']);
            }
        }
        
        if ($version > 151) {
            if ($this->session->data['payment_country_id'] || $this->session->data['payment_zone_id']) {
                $this->tax->setPaymentAddress($this->session->data['payment_country_id'], $this->session->data['payment_zone_id']);
            } else {
                unset($this->session->data['payment_country_id']);
                unset($this->session->data['payment_zone_id']);
                
                $this->tax->setPaymentAddress(0, 0);
            
                if (!$this->customer->isLogged() && $this->config->get('config_tax_default') == 'payment') {
                    $this->tax->setPaymentAddress($this->config->get('config_country_id'), $this->config->get('config_zone_id'));
                }
            }
        }
    }

    private function validate() {
        $error = false;

        if (!$this->simplecheckout->validateFields()) {
            $error = true;
        }
        
        if ($error) {
            $this->simplecheckout->addError();
        }

        self::$error = $error;
        
        return !$error;
    }
}
?>