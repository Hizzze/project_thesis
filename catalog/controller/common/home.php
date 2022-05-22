<?php
class ControllerCommonHome extends Controller {
    private function buildMenu($menu, $parent_id = 0) {
        $newMenu = [];

        foreach($menu as $m) {
            if($parent_id == $m['parent_id']) {
                $newMenuItem = $m;
                $newMenuItem['image'] = ($m['image']) ? '/image/' . $m['image'] : '';
                $newMenuItem['children'] = $this->buildMenu($menu, $m['menu_id']);

                $newMenu[] = $newMenuItem;
            }
        }

        return $newMenu;
    }
	public function index() {
        $data['type'] = true;

		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));

        $this->load->model('catalog/category');
        $this->load->model('tool/image');

		if (isset($this->request->get['route'])) {
			$this->document->addLink(trim($this->config->get('config_url'), '/'), 'canonical');
		}

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');




        $filter_data = array(
            'sort' => 'p.date_added-DESC',
            'order' => 'DESC',
            'start' => 0,
            'limit' => 8
        );

        $results = $this->model_catalog_product->getProducts($filter_data);
        $data['new'] = [];
        foreach ($results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], 189, 189);
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', 189, 189);
            }

            if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                $priceProduct = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            } else {
                $priceProduct = false;
            }

            if ((float)$result['special']) {
                $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            } else {
                $special = false;
            }

            if ($this->config->get('config_tax')) {
                $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
            } else {
                $tax = false;
            }

            if ($this->config->get('config_review_status')) {
                $rating = (int)$result['rating'];
            } else {
                $rating = false;
            }

            $var_currency = array();
            $var_currency['value'] = $this->currency->getValue($this->session->data['currency']);
            $var_currency['symbol_left'] = $this->currency->getSymbolLeft($this->session->data['currency']);
            $var_currency['symbol_right'] = $this->currency->getSymbolRight($this->session->data['currency']);
            $var_currency['decimals'] = $this->currency->getDecimalPlace($this->session->data['currency']);
            $var_currency['decimal_point'] = $this->language->get('decimal_point');
            $var_currency['thousand_point'] = $this->language->get('thousand_point');
            $data['currency'] = $var_currency;
            $options = $this->model_catalog_product->getProductOptions($result['product_id']);

            $options22 = array();
            foreach ($options as $option) {
                $product_option_value_data = array();

                foreach ($option['product_option_value'] as $option_value) {
                    if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
                        if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
                            $price = $this->currency->format($this->tax->calculate($option_value['price'], $result['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
                        } else {
                            $price = false;
                        }

                        $product_option_value_data[] = array(
                            'product_option_value_id' => $option_value['product_option_value_id'],
                            'option_value_id' => $option_value['option_value_id'],
                            'name' => $option_value['name'],
                            'image' => $this->model_tool_image->resize($option_value['image'], 50, 50),
                            'price' => $price,
                            'price_prefix' => $option_value['price_prefix']
                        );
                    }
                }

                $options22[] = array(
                    'product_option_id' => $option['product_option_id'],
                    'product_option_value' => $product_option_value_data,
                    'option_id' => $option['option_id'],
                    'name' => $option['name'],
                    'type' => $option['type'],
                    'value' => $option['value'],
                    'required' => $option['required']
                );
            }

            $lang = $this->language->get('code');

            switch ($lang) {
                case 'en':
                    $description = $result['ean'];
                    break;

                case 'ru':
                    $description = $result['jan'];
                    break;

                default:
                    $description = $result['jan'];
            }


            // Wishlist
            if ($this->customer->isLogged()) {
                $in_wishlist = $this->model_account_wishlist->hasWishlist($result['product_id']);
            } else {
                $in_wishlist = false;
            }

            // Compare
            $in_compare = false;
            foreach ($this->session->data['compare'] as $key => $product_id) {
                if ($product_id == $result['product_id']) {
                    $in_compare = true;
                    break;
                }
            }

            if ($result['quantity'] <= 0) {
                $test = false;
                $stock = $result['stock_status'];
            } elseif ($this->config->get('config_stock_display')) {
                $test = true;
                $stock = $result['quantity'];
            } else {
                $test = true;
                $stock = $this->language->get('text_instock');
            }

            $discount = $result['special'] * 100 / $result['price'];

            $categoryProduct = $this->model_catalog_category->getCategory($result['category_id']);
            $categoryProduct['href'] = $this->url->link('product/category', 'path=' . $categoryProduct['category_id'], true);

            $data['new'][] = array(
                'product_id' => $result['product_id'],
                'thumb' => $image,
                'name' => $result['name'],
                'description' => $description,
                'price' => $priceProduct,
                'special' => $special,
                'tax' => $tax,
                'category' => $categoryProduct,
                'test' => $test,
                'stock' => $stock,
                'attributes' => $this->model_catalog_product->getProductAttributes($result['product_id']),
                'discount' => round($discount) ? 100 - round($discount) : 0,
                'in_cart' => $this->cart->has($result['product_id']),
                'in_wishlist' => $in_wishlist,
                'in_compare' => $in_compare,
                'minimum' => $result['minimum'] > 0 ? $result['minimum'] : 1,
                'rating' => $result['rating'],
                'reviews' => $result['reviews'],
                'href' => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url),
                'options' => $options22,
                'price_no_format' => $result['price'],
                'special_no_format' => $result['special'],
            );
        }










        $filter_data = array(
            'sort' => 'p.sort_order-DESC',
            'order' => 'DESC',
            'start' => 0,
            'limit' => 8,
            'filter_category_id' => 476,
        );

        $results = $this->model_catalog_product->getProducts($filter_data);
        $data['sale'] = [];
        foreach ($results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], 189, 189);
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', 189, 189);
            }

            if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                $priceProduct = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            } else {
                $priceProduct = false;
            }

            if ((float)$result['special']) {
                $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            } else {
                $special = false;
            }

            if ($this->config->get('config_tax')) {
                $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
            } else {
                $tax = false;
            }

            if ($this->config->get('config_review_status')) {
                $rating = (int)$result['rating'];
            } else {
                $rating = false;
            }

            $var_currency = array();
            $var_currency['value'] = $this->currency->getValue($this->session->data['currency']);
            $var_currency['symbol_left'] = $this->currency->getSymbolLeft($this->session->data['currency']);
            $var_currency['symbol_right'] = $this->currency->getSymbolRight($this->session->data['currency']);
            $var_currency['decimals'] = $this->currency->getDecimalPlace($this->session->data['currency']);
            $var_currency['decimal_point'] = $this->language->get('decimal_point');
            $var_currency['thousand_point'] = $this->language->get('thousand_point');
            $data['currency'] = $var_currency;
            $options = $this->model_catalog_product->getProductOptions($result['product_id']);

            $options22 = array();
            foreach ($options as $option) {
                $product_option_value_data = array();

                foreach ($option['product_option_value'] as $option_value) {
                    if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
                        if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
                            $price = $this->currency->format($this->tax->calculate($option_value['price'], $result['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
                        } else {
                            $price = false;
                        }

                        $product_option_value_data[] = array(
                            'product_option_value_id' => $option_value['product_option_value_id'],
                            'option_value_id' => $option_value['option_value_id'],
                            'name' => $option_value['name'],
                            'image' => $this->model_tool_image->resize($option_value['image'], 50, 50),
                            'price' => $price,
                            'price_prefix' => $option_value['price_prefix']
                        );
                    }
                }

                $options22[] = array(
                    'product_option_id' => $option['product_option_id'],
                    'product_option_value' => $product_option_value_data,
                    'option_id' => $option['option_id'],
                    'name' => $option['name'],
                    'type' => $option['type'],
                    'value' => $option['value'],
                    'required' => $option['required']
                );
            }

            $lang = $this->language->get('code');

            switch ($lang) {
                case 'en':
                    $description = $result['ean'];
                    break;

                case 'ru':
                    $description = $result['jan'];
                    break;

                default:
                    $description = $result['jan'];
            }


            // Wishlist
            if ($this->customer->isLogged()) {
                $in_wishlist = $this->model_account_wishlist->hasWishlist($result['product_id']);
            } else {
                $in_wishlist = false;
            }

            // Compare
            $in_compare = false;
            foreach ($this->session->data['compare'] as $key => $product_id) {
                if ($product_id == $result['product_id']) {
                    $in_compare = true;
                    break;
                }
            }

            if ($result['quantity'] <= 0) {
                $test = false;
                $stock = $result['stock_status'];
            } elseif ($this->config->get('config_stock_display')) {
                $test = true;
                $stock = $result['quantity'];
            } else {
                $test = true;
                $stock = $this->language->get('text_instock');
            }

            $discount = $result['special'] * 100 / $result['price'];

            $categoryProduct = $this->model_catalog_category->getCategory($result['category_id']);
            $categoryProduct['href'] = $this->url->link('product/category', 'path=' . $categoryProduct['category_id'], true);

            $data['sale'][] = array(
                'product_id' => $result['product_id'],
                'thumb' => $image,
                'name' => $result['name'],
                'description' => $description,
                'price' => $priceProduct,
                'special' => $special,
                'tax' => $tax,
                'category' => $categoryProduct,
                'test' => $test,
                'stock' => $stock,
                'attributes' => $this->model_catalog_product->getProductAttributes($result['product_id']),
                'discount' => round($discount) ? 100 - round($discount) : 0,
                'in_cart' => $this->cart->has($result['product_id']),
                'in_wishlist' => $in_wishlist,
                'in_compare' => $in_compare,
                'minimum' => $result['minimum'] > 0 ? $result['minimum'] : 1,
                'rating' => $result['rating'],
                'reviews' => $result['reviews'],
                'href' => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url),
                'options' => $options22,
                'price_no_format' => $result['price'],
                'special_no_format' => $result['special'],
            );
        }



        // $data['informations'] = array();

        // $categories = $this->model_catalog_category->getTopCategories();

        // foreach($categories as $category) {

        //     if ($category['image']) {
        //         $image = $this->model_tool_image->resize($category['image'], 117, 117);
        //     } else {
        //         $image = '';
        //     }


        //     $data['categories'][] = array(
        //         'name'     => $category['name'],
        //         'image'     => $image,
        //         'column'   => $category['column'] ? $category['column'] : 1,
        //         'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
        //     );
        // }

        // foreach ($this->model_catalog_information->getInformations( 5 ) as $result) {
        //     if ($result['bottom']) {
        //         $data['informations'][] = array(
        //             'title' => $result['title'],
        //             'description' => $result['description'],
        //             'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
        //         );
        //     }
        // }

        $data['text'] = [
            'home_header_new' => $this->language->get('home_header_new'),
            'home_header_sale' => $this->language->get('home_header_sale'),
            'bottom_form_header' => $this->language->get('bottom_form_header'),
            'your_name' => $this->language->get('your_name'),
            'your_email' => $this->language->get('your_email'),
        ];

        // $data['scheme'] = $this->load->view('common/homeSchemes/home' . $this->config->get('config_scheme_home'), $data);

		$this->response->setOutput($this->load->view('common/home', $data));
	}
}
