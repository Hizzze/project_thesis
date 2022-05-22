<?php

class ControllerCommonYml extends Controller
{
    public function index()
    {
//        if($this->cache->get('yml')) {
//            $output = $this->cache->get('yml');
//        } else {
        if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
            $base = $this->config->get('config_ssl');
        } else {
            $base = $this->config->get('config_url');
        }

        $output = '<?xml version="1.0" encoding="UTF-8"?>';
        $output .= '<yml_catalog date="' . date('Y-m-d H:i') . '">';
        $output .= '<shop>';
        $output .= '<name>' . $this->config->get('config_name') . '</name>';
        $output .= '<company>' . $this->config->get('config_name') . '</company>';
        $output .= '<url>' . $base . '</url>';
        $output .= '<currencies>';

        $this->load->model('localisation/currency');
        $this->data['allcurrencies'] = array();
        $results = $this->model_localisation_currency->getCurrencies();
        foreach ($results as $result) {
            if ($result['status']) {
                $output .= '<currency id="' . $result['code'] . '" rate="' . $result['value'] . '"/>';
            }
        }

        $output .= '</currencies>';

        $this->load->model('catalog/category');
        $results = $this->model_catalog_category->getAllCategories();

        $output .= '<categories>';
        foreach ($results as $result) {
            if ($result['parent_id']) {
                $output .= '<category id="' . $result['category_id'] . '" parentId="' . $result['parent_id'] . '">' . $result['name'] . '</category>';
            } else {
                $output .= '<category id="' . $result['category_id'] . '">' . $result['name'] . '</category>';
            }
        }
        $output .= '</categories>';

        $output .= '<offers>';

        $this->load->model('catalog/product');
        $results = $this->model_catalog_product->getProducts(['limit' => 10000000000]);
        foreach ($results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
            }

            if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                $price = $this->currency->convert($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), false, $this->session->data['currency']);
            } else {
                $price = false;
            }

            if ((float)$result['special']) {
                $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            } else {
                $special = false;
            }

            $categories = $this->model_catalog_product->getCategories($result['product_id']);
            $category = $categories[0];

            $attributes = $this->model_catalog_product->getProductAttributes($result['product_id']);

            $output .= '<offer id="' . $result['product_id'] . '" available="' . ($result['status'] ? 'true' : 'false') . '">';
            $output .= '<url>' . $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id']) . '</url>';

            if($special) {
                $output .= '<oldprice>' . $price . '</oldprice>';
                $output .= '<price>' . $special . '</price>';
            } else {
                $output .= '<price>' . $price . '</price>';
            }

            $output .= '<currencyId>' . $this->session->data['currency'] . '</currencyId>';
            $output .= '<categoryId>' . ($category ? $category['category_id'] : 0) . '</categoryId>';
            $output .= '<picture>' . $image . '</picture>';

            $output .= '<name><![CDATA[' . htmlspecialchars_decode(str_replace('"', '&quot;', $result['name'])) . ']]></name>';
            if ($result['description']) {
                $output .= '<description>';
                $output .= '<![CDATA[';
                $output .= htmlspecialchars_decode($result['description']);
                $output .= ']]>';
                $output .= '</description>';
            }


            foreach($attributes as $a) {
                foreach($a['attribute'] as $b) {
                    $output .= '<param name="' . $b['name'] . '">' . $b['text'] . '</param>';
                }
            }

            $output .= '</offer>';
        }

        $output .= '</offers>';
        $output .= '</shop>';
        $output .= '</yml_catalog>';

        $this->cache->set('yml', $output);
//        }

        $this->response->addHeader('Content-Type: application/xml');
        $this->response->setOutput($output);
    }
}