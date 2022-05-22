<?php
class ControllerCommonFooter extends Controller {
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
		$this->load->language('common/footer');
        $this->load->model('design/menu');
        
        $menu = $this->model_design_menu->getMenuByType('mobile' . ($this->session->data['language'] == 'ua'  ? '_ua' : ''));
		$data['menu'] = $this->buildMenu($menu);
		
		$data['scripts'] = $this->document->getScripts('footer');

		$data['text_information'] = $this->language->get('text_information');
		$data['text_service'] = $this->language->get('text_service');
		$data['text_extra'] = $this->language->get('text_extra');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_sitemap'] = $this->language->get('text_sitemap');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_voucher'] = $this->language->get('text_voucher');
		$data['text_affiliate'] = $this->language->get('text_affiliate');
		$data['text_special'] = $this->language->get('text_special');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_newsletter'] = $this->language->get('text_newsletter');

		$this->load->model('catalog/information');

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}

		$data['contact'] = $this->url->link('information/contact');
		$data['return'] = $this->url->link('account/return/add', '', true);
		$data['sitemap'] = $this->url->link('information/sitemap');
		$data['manufacturer'] = $this->url->link('product/manufacturer');
		$data['voucher'] = $this->url->link('account/voucher', '', true);
		$data['affiliate'] = $this->url->link('affiliate/account', '', true);
		$data['special'] = $this->url->link('product/special');
		$data['account'] = $this->url->link('account/account', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['newsletter'] = $this->url->link('account/newsletter', '', true);

        $data['home'] = trim($this->url->link('common/home'), '/');
        $data['name'] = $this->config->get('config_name');

        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }

        if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
            $data['logo'] = $server . 'image/' . $this->config->get('config_logo');
        } else {
            $data['logo'] = '';
        }

		$data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->addOnline($ip, $this->customer->getId(), $url, $referer);
		}

        $data['db_footer'] = htmlspecialchars_decode(
            $this->model_extension_module->getModule(44)['module_description'][(int)$this->config->get('config_language_id')]['description']
        );

		$data['text'] = [
            'addtocart_header' => $this->language->get('addtocart_header'),
            'addtocart_continue' => $this->language->get('addtocart_continue'),
            'addtocart_checkout' => $this->language->get('addtocart_checkout'),
            'callback_header' => $this->language->get('callback_header'),
			'callback_button' => $this->language->get('callback_button'),
			
            'your_name' => $this->language->get('your_name'),
            'your_phone' => $this->language->get('your_phone'),
        ];
		return $this->load->view('common/footer', $data);
	}
}
