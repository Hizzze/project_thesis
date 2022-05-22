<?php
class ControllerExtensionModuleFeatured extends Controller {
	public function index($setting) {
		$this->load->language('extension/module/featured');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

        if ($this->customer->isLogged()) {
            $this->load->model('account/wishlist');
        }

		$data['products'] = array();

		if (!$setting['limit']) {
			$setting['limit'] = 4;
		}

		if (!empty($setting['product'])) {
			$products = array_slice($setting['product'], 0, (int)$setting['limit']);

			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}

					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$price = false;
					}

					if ((float)$product_info['special']) {
						$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$special = false;
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = $product_info['rating'];
					} else {
						$rating = false;
					}
                    $options = $this->model_catalog_product->getProductOptions($product_info['product_id']);

                    $options22 = array();
                    foreach( $options as $option ) {
                        $product_option_value_data = array();

                        foreach ($option['product_option_value'] as $option_value) {
                            if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
                                if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
                                    $price2 = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
                                } else {
                                    $price2 = false;
                                }

                                $product_option_value_data[] = array(
                                    'product_option_value_id' => $option_value['product_option_value_id'],
                                    'option_value_id'         => $option_value['option_value_id'],
                                    'name'                    => $option_value['name'],
                                    'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
                                    'price'                   => $price2,
                                    'price_prefix'            => $option_value['price_prefix']
                                );
                            }
                        }

                        $options22[] = array(
                            'product_option_id'    => $option['product_option_id'],
                            'product_option_value' => $product_option_value_data,
                            'option_id'            => $option['option_id'],
                            'name'                 => $option['name'],
                            'type'                 => $option['type'],
                            'value'                => $option['value'],
                            'required'             => $option['required']
                        );
                    }

                    $lang = $this->language->get('code');

                    switch ( $lang ) {
                        case 'en':
                            $description = $product_info['ean'];
                            break;

                        case 'ru':
                            $description = $product_info['jan'];
                            break;

                        default:
                            $description = $product_info['jan'];
                    }

                    // Wishlist
                    if ($this->customer->isLogged()) {
                        $in_wishlist = $this->model_account_wishlist->hasWishlist($product_info['product_id']);
                    } else {
                        $in_wishlist = false;
                    }

                    // Compare
                    $in_compare = false;
                    foreach ($this->session->data['compare'] as $key => $product_id) {
                        if( $product_id == $product_info['product_id'] ) {
                            $in_compare = true;
                            break;
                        }
                    }
                    if ($product_info['quantity'] <= 0) {
                        $test = false;
                        $stock = $product_info['stock_status'];
                    } elseif ($this->config->get('config_stock_display')) {
                        $test = true;
                        $stock = $product_info['quantity'];
                    } else {
                        $test = true;
                        $stock = $this->language->get('text_instock');
                    }
					$data['products'][] = array(
						'product_id'  => $product_info['product_id'],
						'thumb'       => $image,
						'name'        => $product_info['name'],
                        'description' => htmlspecialchars_decode( $description ),
						'price'       => $price,
						'special'     => $special,
						'tax'         => $tax,
                        'test'        => $test,
                        'stock'       => $stock,
                        'in_cart' => $this->cart->has( $product_info['product_id'] ),
						'rating'      => $rating,
                        'in_wishlist' => $in_wishlist,
                        'in_compare' => $in_compare,
                        'reviews'     => $product_info['reviews'],
                        'options' => $options22,
						'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
					);
				}
			}
		}

        $data['text'] = [
            'catalog_reviews' => $this->language->get('catalog_reviews'),
            'product_in_stock' => $this->language->get('product_in_stock'),
            'product_out_of_stock' => $this->language->get('product_out_of_stock'),
        ];

		if ($data['products']) {
			return $this->load->view('extension/module/featured', $data);
		}
	}
}