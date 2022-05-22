<?php

class ControllerProductCategory extends Controller
{
    public function index()
    {
        $this->load->language('product/category');

        $this->load->model('catalog/category');

        $this->load->model('catalog/product');


        // Wishlist
        if ($this->customer->isLogged()) {
            $this->load->model('account/wishlist');
        }

        $this->load->model('tool/image');

        if (isset($this->request->get['filter'])) {
            $filter = $this->request->get['filter'];
        } else {
            $filter = '';
        }

        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'p.sort_order-DESC';
        }

        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'DESC';
        }

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        if (isset($this->request->get['limit'])) {
            $limit = (int)$this->request->get['limit'];
        } else {
            $limit = 40;
        }


        // OCFilter start
        if (isset($this->request->get['filter_ocfilter'])) {
            $filter_ocfilter = $this->request->get['filter_ocfilter'];
        } else {
            $filter_ocfilter = '';
        }
        // OCFilter end

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => trim($this->url->link('common/home'), '/')
        );

        if (isset($this->request->get['path'])) {
            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $path = '';

            $parts = explode('_', (string)$this->request->get['path']);

            $category_id = (int)array_pop($parts);

            foreach ($parts as $path_id) {
                if (!$path) {
                    $path = (int)$path_id;
                } else {
                    $path .= '_' . (int)$path_id;
                }

                $category_info = $this->model_catalog_category->getCategory($path_id);

                if ($category_info) {
                    $data['breadcrumbs'][] = array(
                        'text' => $category_info['name'],
                        'href' => $this->url->link('product/category', 'path=' . $path . $url)
                    );
                }
            }
        } else {
            $category_id = 0;
        }

        $category_info = $this->model_catalog_category->getCategory($category_id);

        if ($category_info) {
            $this->document->setTitle($category_info['meta_title'] ? $category_info['meta_title'] : str_ireplace(
                array('<category>', '<company>'),
                array($category_info['name'], $this->config->get('config_meta_title')),
                html_entity_decode($this->language->get('seo_category_meta_title'))
            ));

            $this->document->setDescription($category_info['meta_description'] ? $category_info['meta_description'] : str_ireplace(
                array('<category>', '<company>'),
                array($category_info['name'], $this->config->get('config_meta_title')),
                html_entity_decode($this->language->get('seo_category_meta_description'))
            ));

            $this->document->setKeywords($category_info['meta_keyword'] ? $category_info['meta_keyword'] : str_ireplace(
                array('<category>', '<company>'),
                array($category_info['name'], $this->config->get('config_meta_title')),
                html_entity_decode($this->language->get('seo_category_meta_keywords'))
            ));

            $data['heading_title'] = $category_info['name'];

            $data['text_refine'] = $this->language->get('text_refine');
            $data['text_empty'] = $this->language->get('text_empty');
            $data['text_quantity'] = $this->language->get('text_quantity');
            $data['text_manufacturer'] = $this->language->get('text_manufacturer');
            $data['text_model'] = $this->language->get('text_model');
            $data['text_price'] = $this->language->get('text_price');
            $data['text_tax'] = $this->language->get('text_tax');
            $data['text_points'] = $this->language->get('text_points');
            $data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
            $data['text_sort'] = $this->language->get('text_sort');
            $data['text_limit'] = $this->language->get('text_limit');
            $data['text_select'] = $this->language->get('text_select');

            $data['button_cart'] = $this->language->get('button_cart');
            $data['button_wishlist'] = $this->language->get('button_wishlist');
            $data['button_compare'] = $this->language->get('button_compare');
            $data['button_continue'] = $this->language->get('button_continue');
            $data['button_list'] = $this->language->get('button_list');
            $data['button_grid'] = $this->language->get('button_grid');

            // Set the last category breadcrumb
            $data['breadcrumbs'][] = array(
                'text' => $category_info['name'],
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'])
            );

            if ($category_info['image']) {
                $data['thumb'] = $this->model_tool_image->resize($category_info['image'], 189, 189);
            } else {
                $data['thumb'] = '';
            }

            if ($category_info['image2']) {
                $data['banner'] = $this->model_tool_image->link($category_info['image2']);
            } else {
                $data['banner'] = '';
            }
            
            if($page <= 1) {
                $data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
            } else {

            }

            $data['compare'] = $this->url->link('product/compare');
            $this->load->model('extension/news');
            $filter_data = array(
                'page' => 1,
                'limit' => 5,
                'start' => 0,
                'category_id' => $category_id
            );

            $all_news = $this->model_extension_news->getAllNews($filter_data);

            $news_setting = array();

            if ($this->config->get('news_setting')) {
                $news_setting = $this->config->get('news_setting');
            }else{
                $news_setting['description_limit'] = '100';
                $news_setting['news_thumb_width'] = '220';
                $news_setting['news_thumb_height'] = '220';
            }

            foreach ($all_news as $news) {
                if($news['image']){
                    $image = $this->model_tool_image->resize($news['image'], $news_setting['news_thumb_width'], $news_setting['news_thumb_height']);
                }else{
                    $image = false;
                }

                $data['all_news'][] = array (
                    'title' 		=> html_entity_decode($news['title'], ENT_QUOTES),
                    'image'			=> $image,
                    'description' => (utf8_strlen(strip_tags(html_entity_decode($news['description'], ENT_QUOTES))) > $news_setting['description_limit'] ? utf8_substr(strip_tags(html_entity_decode($news['description'], ENT_QUOTES)), 0, $news_setting['description_limit']) . '...' : strip_tags(html_entity_decode($news['description'], ENT_QUOTES))),
                    'view' 			=> $this->url->link('information/news/info', 'news_id=' . $news['news_id']),
                    'date_added' 	=> date($this->language->get('date_format_short'), strtotime($news['date_added']))
                );
            }

            $url = '';

            if (isset($this->request->get['filter'])) {
                $url .= '&filter=' . $this->request->get['filter'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $data['categories'] = array();

            $results = $this->model_catalog_category->getCategories($category_id);

            foreach ($results as $result) {
                $filter_data = array(
                    'filter_category_id' => $result['category_id'],
                    'filter_sub_category' => true
                );

                $data['categories'][] = array(
                    'name' => $result['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
                    'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url)
                );
            }

            $data['products'] = array();

            $filter_data = array(
                'filter_category_id' => $category_id,
                'filter_filter' => $filter,
                'sort' => $sort,
                'order' => $order,
                'start' => ($page - 1) * $limit,
                'limit' => $limit
            );

            // OCFilter start
            $filter_data['filter_ocfilter'] = $filter_ocfilter;
            // OCFilter end

            $product_total = $this->model_catalog_product->getTotalProducts($filter_data);

            $results = $this->model_catalog_product->getProducts($filter_data);

            foreach ($results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], 367, 367);
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', 367, 367);
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
 
                $data['products'][] = array(
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

            $url = '';

            // OCFilter start
            if (isset($this->request->get['filter_ocfilter'])) {
                $url .= '&filter_ocfilter=' . $this->request->get['filter_ocfilter'];
            }
            // OCFilter end

            if (isset($this->request->get['filter'])) {
                $url .= '&filter=' . $this->request->get['filter'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $data['sorts'] = array();

            $data['sorts'][] = array(
                'text' => $this->language->get('text_default'),
                'value' => 'p.sort_order-DESC',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.sort_order&order=DESC' . $url)
            );

            $data['sorts'][] = array(
                'text' => $this->language->get('sort_name_asc'),
                'value' => 'pd.name-ASC',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=ASC' . $url)
            );

            $data['sorts'][] = array(
                'text' => $this->language->get('sort_name_desc'),
                'value' => 'pd.name-DESC',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=DESC' . $url)
            );

            $data['sorts'][] = array(
                'text' => $this->language->get('sort_price_asc'),
                'value' => 'p.price-ASC',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=ASC' . $url)
            );

            $data['sorts'][] = array(
                'text' => $this->language->get('sort_price_desc'),
                'value' => 'p.price-DESC',
                'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=DESC' . $url)
            );

            $data['link_order']['asc'] =
                $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&order=ASC' . $url);

            $data['link_order']['desc'] =
                $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&order=DESC' . $url);

            if ($this->config->get('config_review')) {
                $data['sorts'][] = array(
                    'text' => $this->language->get('text_rating'),
                    'value' => 'rating',
                    'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating' . $url)
                );

                $url = '';
            }

            // OCFilter start
            if (isset($this->request->get['filter_ocfilter'])) {
                $url .= '&filter_ocfilter=' . $this->request->get['filter_ocfilter'];
            }
            // OCFilter end

            if (isset($this->request->get['filter'])) {
                $url .= '&filter=' . $this->request->get['filter'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            $data['limits'] = array();

            $limits = array_unique(array(40, 100));

            sort($limits);

            foreach ($limits as $value) {
                $data['limits'][] = array(
                    'text' => $value,
                    'value' => $value,
                    'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=' . $value)
                );
            }

            $url = '';

            // OCFilter start
            if (isset($this->request->get['filter_ocfilter'])) {
                $url .= '&filter_ocfilter=' . $this->request->get['filter_ocfilter'];
            }
            // OCFilter end

            if (isset($this->request->get['filter'])) {
                $url .= '&filter=' . $this->request->get['filter'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $pagination = new Pagination();
            $pagination->total = $product_total;
            $pagination->page = $page;
            $pagination->limit = $limit;
            $pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}');

            $data['pagination'] = $pagination->render();

            $data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

            // http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
            if ($page == 1) {
//                $this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], true), 'canonical');
            } elseif ($page == 2) {
                $this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], true), 'prev');
            } else {
                $this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page=' . ($page - 1), true), 'prev');
            }

            if ($limit && ceil($product_total / $limit) > $page) {
                $this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page=' . ($page + 1), true), 'next');
            }

            $data['sort'] = $sort;
            $data['order'] = $order;
            $data['limit'] = $limit;

            // OCFilter Start
            $ocfilter_page_info = $this->load->controller('extension/module/ocfilter/getPageInfo');

            if ($ocfilter_page_info) {
                $this->document->setTitle($ocfilter_page_info['meta_title']);

                if ($ocfilter_page_info['meta_description']) {
                    $this->document->setDescription($ocfilter_page_info['meta_description']);
                }

                if ($ocfilter_page_info['meta_keyword']) {
                    $this->document->setKeywords($ocfilter_page_info['meta_keyword']);
                }

                $data['heading_title'] = $ocfilter_page_info['title'];

                if ($ocfilter_page_info['description'] && !isset($this->request->get['page']) && !isset($this->request->get['sort']) && !isset($this->request->get['order']) && !isset($this->request->get['search']) && !isset($this->request->get['limit'])) {
                    $data['description'] = html_entity_decode($ocfilter_page_info['description'], ENT_QUOTES, 'UTF-8');
                }
            } else {
                $meta_title = $this->document->getTitle();
                $meta_description = $this->document->getDescription();
                $meta_keyword = $this->document->getKeywords();

                $filter_title = $this->load->controller('extension/module/ocfilter/getSelectedsFilterTitle');

                if ($filter_title['filter_title']) {
                    if (false !== strpos($meta_title, '<filter>')) {
                        $meta_title = trim(str_replace('<filter>', $filter_title['filter_title'], $meta_title));
                    } else {
                        $meta_title .= ' ' . $filter_title['filter_title'];
                    }

                    $this->document->setTitle($meta_title);

                    if ($meta_description) {
                        if (false !== strpos($meta_description, '<filter>')) {
                            $meta_description = trim(str_replace('<filter>', $filter_title['filter_title'], $meta_description));
                        } else {
                            $meta_description .= ' ' . $filter_title['filter_title'];
                        }

                        $this->document->setDescription($meta_description);
                    }

                    if ($meta_keyword) {
                        if (false !== strpos($meta_keyword, '<filter>')) {
                            $meta_keyword = trim(str_replace('<filter>', $filter_title['filter_title'], $meta_keyword));
                        } else {
                            $meta_keyword .= ' ' . $filter_title['filter_title'];
                        }

                        $this->document->setKeywords($meta_keyword);
                    }

                    if($filter_title['count'] <= 1) {
                        $heading_title = $data['heading_title'];

                        if (false !== strpos($heading_title, '<filter>')) {
                            $heading_title = trim(str_replace('<filter>', $filter_title['filter_title'], $heading_title));
                        } else {
                            $heading_title .= ', ' . $filter_title['filter_title'];
                        }

                        $data['heading_title'] = $heading_title;
                    } else {
                        $this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], true), 'canonical');
                    }
                    $data['description'] = '';
                } else {
                    $this->document->setTitle(trim(str_replace('<filter>', '', $meta_title)));
                    $this->document->setDescription(trim(str_replace('<filter>', '', $meta_description)));
                    $this->document->setKeywords(trim(str_replace('<filter>', '', $meta_keyword)));

                    if($filter_title['count'] <= 1) {
                        $data['heading_title'] = trim(str_replace('<filter>', '', $data['heading_title']));
                    } else {
                        $this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], true), 'canonical');
                    }
                }
            }
            // OCFilter End

            $data['selected_options'] = $this->load->controller('extension/module/ocfilter/getSelectedOptions');
            $data['category_href'] = $this->url->link('product/category', 'path=' . $category_info['category_id'], true);

            $data['product_total'] = $product_total;

            $data['continue'] = trim($this->url->link('common/home'), '/');

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            $data['text'] = [
                'catalog_sort_by' => $this->language->get('catalog_sort_by'),
                'filters_rest' => $this->language->get('filters_reset'),
            ];

            $this->response->setOutput($this->load->view('product/category', $data));
        } else {
            $url = '';

            if (isset($this->request->get['path'])) {
                $url .= '&path=' . $this->request->get['path'];
            }

            if (isset($this->request->get['filter'])) {
                $url .= '&filter=' . $this->request->get['filter'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_error'),
                'href' => $this->url->link('product/category', $url)
            );

            $this->document->setTitle($this->language->get('text_error'));

            $data['heading_title'] = $this->language->get('text_error');

            $data['text_error'] = $this->language->get('text_error');

            $data['button_continue'] = $this->language->get('button_continue');

            $data['continue'] = trim($this->url->link('common/home'), '/');

            $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            $this->response->setOutput($this->load->view('error/not_found', $data));
        }
    }
}