<?php
class ModelExtensionShippingAustralia extends Model {
    function getQuote($address) {
        $this->load->language('extension/shipping/australia');

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$this->config->get('australia_geo_zone_id') . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");

        if (!$this->config->get('australia_geo_zone_id')) {
            $status1 = true;
        } elseif ($query->num_rows) {
            $status1 = true;
        } else {
            $status1 = false;
        }

        if ($this->cart->getSubTotal() >= $this->config->get('australia_total')) {
            $status = true;
        } else {
            $status = false;
        }


        $quote_data = array();
        $method_data = array();


        if( $status1 ) {
            if ($status) {
                $quote_data['australia'] = array(
                    'code'         => 'australia.australia',
                    'title'        => $this->language->get('text_description'),
                    'cost'         => 0,
                    'tax_class_id' => 0,
                    'text'         => $this->currency->format(0, $this->session->data['currency'])
                );

                $method_data = array(
                    'code'       => 'australia',
                    'title'      => $this->language->get('text_title_free'),
                    'quote'      => $quote_data,
                    'sort_order' => $this->config->get('australia_sort_order'),
                    'error'      => false
                );
            } else {
                $quote_data = array();

                $quote_data['australia'] = array(
                    'code'         => 'australia.australia',
                    'title'        => $this->language->get('text_description'),
                    'cost'         => $this->config->get('australia_cost'),
                    'tax_class_id' => 0,
                    'text'         => $this->currency->format($this->config->get('australia_cost'), $this->session->data['currency'])
                );


                $method_data = array(
                    'code'       => 'australia',
                    'title'      => $this->language->get('text_title_cost'),
                    'quote'      => $quote_data,
                    'sort_order' => $this->config->get('australia_sort_order'),
                    'error'      => false
                );
            }
        }

        return $method_data;
    }
}