<?php
class ControllerCommonHeader extends Controller {
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
        // Analytics
        $this->load->model('extension/extension');

        $this->load->model('design/menu');
        
        $menu = $this->model_design_menu->getMenuByType('header' . ($this->session->data['language'] == 'ua'  ? '_ua' : ''));
        $data['menu'] = $this->buildMenu($menu);

        $topMenu = $this->model_design_menu->getMenuByType('top' . ($this->session->data['language'] == 'ua'  ? '_ua' : ''));
        $data['topMenu'] = $this->buildMenu($topMenu);

        $data['analytics'] = array();

        $analytics = $this->model_extension_extension->getExtensions('analytics');

        foreach ($analytics as $analytic) {
            if ($this->config->get($analytic['code'] . '_status')) {
                $data['analytics'][] = $this->load->controller('extension/analytics/' . $analytic['code'], $this->config->get($analytic['code'] . '_status'));
            }
        }

        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }

        if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
            $this->document->addLink($server . 'image/' . $this->config->get('config_icon'), 'icon');
        }

        $data['title'] = $this->document->getTitle();

        $data['base'] = trim($server, '/');
        $data['description'] = $this->document->getDescription();
        $data['keywords'] = $this->document->getKeywords();
        $data['links'] = $this->document->getLinks();
        $data['styles'] = $this->document->getStyles();
        $data['scripts'] = $this->document->getScripts();

        // OCFilter start
        $data['noindex'] = $this->document->isNoindex();
        // OCFilter end


        // OCFilter start
        $data['noindex'] = $this->document->isNoindex();
        // OCFilter end

        $data['lang'] = $this->language->get('code');
        $data['direction'] = $this->language->get('direction');

        $data['name'] = $this->config->get('config_name');

        if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
            $data['logo'] = $server . 'image/' . $this->config->get('config_logo');
        } else {
            $data['logo'] = '';
        }

        $this->load->language('common/header');

        $data['text_home'] = $this->language->get('text_home');

        // Wishlist
        if ($this->customer->isLogged()) {
            $this->load->model('account/wishlist');

            $data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());

            $data['count_wishlist'] = $this->model_account_wishlist->getTotalWishlist();
        } else {
            $data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));

            $data['count_wishlist'] = isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0;
        }

        $data['count_compare'] = isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0;

        $data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
        $data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', true), $this->customer->getFirstName(), $this->url->link('account/logout', '', true));

        $this->load->model('extension/module');

        $data['menu_desktop'] = htmlspecialchars_decode(
            $this->model_extension_module->getModule(39)['module_description'][(int)$this->config->get('config_language_id')]['description']
        );
        $data['menu_mobile'] = htmlspecialchars_decode(
            $this->model_extension_module->getModule(40)['module_description'][(int)$this->config->get('config_language_id')]['description']
        );
        $data['phones_mobile'] = htmlspecialchars_decode(
            $this->model_extension_module->getModule(41)['module_description'][(int)$this->config->get('config_language_id')]['description']
        );

        $data['text_account'] = $this->language->get('text_account');
        $data['text_register'] = $this->language->get('text_register');
        $data['text_login'] = $this->language->get('text_login');
        $data['text_order'] = $this->language->get('text_order');
        $data['text_transaction'] = $this->language->get('text_transaction');
        $data['text_download'] = $this->language->get('text_download');
        $data['text_logout'] = $this->language->get('text_logout');

        $data['text_logout'] = $this->language->get('text_logout');
        $data['text_logout'] = $this->language->get('text_logout');
        $data['text_logout'] = $this->language->get('text_logout');
        $data['text_logout'] = $this->language->get('text_logout');
        $data['text_logout'] = $this->language->get('text_logout');

        $data['text_checkout'] = $this->language->get('text_checkout');
        $data['text_category'] = $this->language->get('text_category');
        $data['text_all'] = $this->language->get('text_all');

        $data['home'] = trim($this->url->link('common/home'), '/');
        $data['wishlist'] = $this->url->link('account/wishlist', '', true);
        $data['compare'] = $this->url->link('product/compare');
        $data['logged'] = $this->customer->isLogged();
        $data['customer'] = $this->customer->getFirstName();
        $data['account'] = $this->url->link('account/account', '', true);
        $data['register'] = $this->url->link('account/register', '', true);
        $data['login'] = $this->url->link('account/login', '', true);
        $data['order'] = $this->url->link('account/order', '', true);
        $data['transaction'] = $this->url->link('account/transaction', '', true);
        $data['download'] = $this->url->link('account/download', '', true);
        $data['logout'] = $this->url->link('account/logout', '', true);
        $data['shopping_cart'] = $this->url->link('checkout/cart');
        $data['checkout'] = $this->url->link('checkout/checkout', '', true);
        $data['contact'] = $this->url->link('information/contact');
        $data['telephone'] = $this->config->get('config_telephone');

        // Menu
        $this->load->model('catalog/category');

        $this->load->model('catalog/product');

        $data['categories'] = array();

        $categories = $this->model_catalog_category->getCategories(0, 1);

        foreach ($categories as $category) {
            if ($category['top']) {
                // Level 2
                $children_data = array();

                $children = $this->model_catalog_category->getCategories($category['category_id']);

                foreach ($children as $child) {

                    // Level 3
                    $children_data2 = array();

                    $children2 = $this->model_catalog_category->getCategories($child['category_id']);

                    foreach ($children2 as $child2) {

                        $filter_data2 = array(
                            'filter_category_id'  => $child2['category_id'],
                            'filter_sub_category' => true
                        );

                        $children_data2[] = array(
                            'name'  => $child2['name'] /* . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data2) . ')' : '') */,
                            'href'  => $this->url->link('product/category', 'path=' . $child['category_id'] . '_' . $child2['category_id'])
                        );
                    }


                    $filter_data = array(
                        'filter_category_id'  => $child['category_id'],
                        'filter_sub_category' => true
                    );

                    $children_data[] = array(
                        'children' => $children_data2,
                        'name'  => $child['name'] /*. ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : '')*/,
                        'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
                    );
                }

                // Level 1
                $data['categories'][] = array(
                    'name'     => $category['name'],
                    'children' => $children_data,
                    'column'   => $category['column'] ? $category['column'] : 1,
                    'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
                );
            }
        }


       
		$this->load->model('catalog/category');
		$this->load->model('catalog/product');



		$data['heading_title'] = $this->language->get('heading_title');

		//auth
		$this->load->language('account/login');
		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_password'] = $this->language->get('entry_password');
		$data['text_forgotten'] = $this->language->get('text_forgotten');
		$data['text_register'] = $this->language->get('text_register');
		$data['menu_title'] = $this->language->get('menu_title');

		$data['button_login'] = $this->language->get('button_login');
		$data['action'] = $this->url->link('account/login', '', 'SSL');
		$data['email'] = "";
		$data['register'] = $this->url->link('account/register', '', 'SSL');
		$data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');

	    $data['language'] = $this->load->controller('common/language');
	    $data['language_mob'] = $this->load->controller('common/language_mob');


        $data['currency'] = $this->load->controller('common/currency');
        $data['search'] = $this->load->controller('common/search');
        $data['cart'] = $this->load->controller('common/cart');

        // For page specific css
        if (isset($this->request->get['route'])) {
            if (isset($this->request->get['product_id'])) {
                $class = '-' . $this->request->get['product_id'];
            } elseif (isset($this->request->get['path'])) {
                $class = '-' . $this->request->get['path'];
            } elseif (isset($this->request->get['manufacturer_id'])) {
                $class = '-' . $this->request->get['manufacturer_id'];
            } elseif (isset($this->request->get['information_id'])) {
                $class = '-' . $this->request->get['information_id'];
            } else {
                $class = '';
            }

            $data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
        } else {
            $data['class'] = 'common-home';
        }

        $data['text'] = [
            'callback_header' => $this->language->get('callback_header'),
            'search_placeholder' => $this->language->get('search_placeholder'),
        ];

        $data['open'] = html_entity_decode($this->config->get('config_open'), ENT_QUOTES, 'UTF-8');

        return $this->load->view('common/header', $data);
    }
}
