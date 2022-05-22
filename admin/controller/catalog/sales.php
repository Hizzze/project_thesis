<?php
class ControllerCatalogSales extends Controller {
    private $error = array();

    public function index() {
        $this->load->language('catalog/sales');

        $this->load->model('catalog/sales');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->getList();
    }

    public function add() {
        $this->load->language('catalog/sales');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('catalog/sales');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_catalog_sales->addSales($this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            $this->response->redirect($this->url->link('catalog/sales', 'token=' . $this->session->data['token'] . $url, true));
        }

        $this->getForm();
    }

    public function edit() {
        $this->load->language('catalog/sales');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('catalog/sales');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_catalog_sales->editSales($this->request->get['sales_id'], $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            $this->response->redirect($this->url->link('catalog/sales', 'token=' . $this->session->data['token'] . $url, true));
        }

        $this->getForm();
    }

    public function delete() {
        $this->load->language('catalog/sales');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('catalog/sales');

        if (isset($this->request->post['selected']) && $this->validateDelete()) {
            foreach ($this->request->post['selected'] as $sales_id) {
                $this->model_catalog_sales->deleteSales($sales_id);
            }

            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            $this->response->redirect($this->url->link('catalog/sales', 'token=' . $this->session->data['token'] . $url, true));
        }

        $this->getList();
    }

    private function getList() {

        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'nd.title';
        }

        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'ASC';
        }

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $url = '';

        $this->load->language('catalog/sales');

        $this->load->model('catalog/sales');

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_list'] = $this->language->get('text_list');
        $data['text_confirm'] = $this->language->get('text_confirm');
        $data['text_no_results'] = $this->language->get('text_no_results');

        $data['column_image'] = $this->language->get('column_image');
        $data['column_title'] = $this->language->get('column_title');
        $data['column_date_start'] = $this->language->get('column_date_start');
        $data['column_date_end'] = $this->language->get('column_date_end');
        $data['column_action'] = $this->language->get('column_action');

        $data['button_add'] = $this->language->get('button_add');
        $data['button_edit'] = $this->language->get('button_edit');
        $data['button_delete'] = $this->language->get('button_delete');
        $data['button_setting'] = $this->language->get('button_setting');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'href'      => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true),
            'text'      => $this->language->get('text_home'),
            'separator' => false
        );

        $data['breadcrumbs'][] = array(
            'href'      => $this->url->link('catalog/sales', 'token=' . $this->session->data['token'], true),
            'text'      => $this->language->get('heading_title'),
            'separator' => ' :: '
        );

        $data['add'] = $this->url->link('catalog/sales/add', 'token=' . $this->session->data['token'], true);
        $data['delete'] = $this->url->link('catalog/sales/delete', 'token=' . $this->session->data['token'], true);
        $data['setting'] = $this->url->link('catalog/sales/setting', 'token=' . $this->session->data['token'], true);

        $sales_total = $this->model_catalog_sales->getTotalSales();

        $this->load->model('tool/image');

        $data['sales'] = array();

        $filter_data = array(
            'sort'  => $sort,
            'order' => $order,
            'start' => ($page - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );

        $results = $this->model_catalog_sales->getSalesList($filter_data);

        foreach ($results as $result) {

            if ($result['thumbnail'] && file_exists(DIR_IMAGE . $result['thumbnail'])) {
                $image = $this->model_tool_image->resize($result['thumbnail'], 40, 40);
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', 40, 40);
            }

            $data['sales'][] = array(
                'sales_id'     	=> $result['sales_id'],
                'title'       	=> $result['title'],
                'image'      	=> $image,
                'date_start'  	=> date($this->language->get('date_format_short'), $result['date_start']),
                'date_end'  	=> date($this->language->get('date_format_short'), $result['date_end']),
                'selected'    	=> isset($this->request->post['selected']) && in_array($result['sales_id'], $this->request->post['selected']),
                'edit'      	=> $this->url->link('catalog/sales/edit', 'token=' . $this->session->data['token'] . '&sales_id=' . $result['sales_id'], true)
            );
        }

        if (isset($this->request->post['selected'])) {
            $data['selected'] = (array)$this->request->post['selected'];
        } else {
            $data['selected'] = array();
        }

        $url = '';

        if ($order == 'ASC') {
            $url .= '&order=DESC';
        } else {
            $url .= '&order=ASC';
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        $data['sort_title'] = $this->url->link('catalog/sales', 'token=' . $this->session->data['token'] . '&sort=nd.title' . $url, true);

        $url = '';

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        $pagination = new Pagination();
        $pagination->total = $sales_total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_limit_admin');
        $pagination->url = $this->url->link('catalog/sales', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($sales_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($sales_total - $this->config->get('config_limit_admin'))) ? $sales_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $sales_total, ceil($sales_total / $this->config->get('config_limit_admin')));

        $data['sort'] = $sort;
        $data['order'] = $order;

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('catalog/sales_total', $data));

    }

    private function getForm() {

        $this->load->language('catalog/sales');

        $this->load->model('catalog/sales');

        $this->document->setTitle($this->language->get('heading_title'));

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_form'] = !isset($this->request->get['sales_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
        $data['text_default'] = $this->language->get('text_default');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_image_manager'] = $this->language->get('text_image_manager');
        $data['text_browse'] = $this->language->get('text_browse');
        $data['text_clear'] = $this->language->get('text_clear');

        $data['text_select_all'] = $this->language->get('text_select_all');
        $data['text_unselect_all'] = $this->language->get('text_unselect_all');
        $data['column_date_added'] = $this->language->get('column_date_added');

        $data['entry_title'] = $this->language->get('entry_title');
        $data['entry_meta_title'] = $this->language->get('entry_meta_title');
        $data['entry_meta_h1'] = $this->language->get('entry_meta_h1');
        $data['entry_meta_description'] = $this->language->get('entry_meta_description');
        $data['entry_meta_keyword'] = $this->language->get('entry_meta_keyword');
        $data['entry_description'] = $this->language->get('entry_description');
        $data['entry_date_added'] = $this->language->get('entry_date_added');
        $data['entry_store'] = $this->language->get('entry_store');
        $data['entry_keyword'] = $this->language->get('entry_keyword');
        $data['entry_image'] = $this->language->get('entry_image');
        $data['entry_status'] = $this->language->get('entry_status');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');

        $data['tab_general'] = $this->language->get('tab_general');
        $data['tab_data'] = $this->language->get('tab_data');

        $data['help_keyword'] = $this->language->get('help_keyword');

        $data['token'] = $this->session->data['token'];

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->error['title'])) {
            $data['error_title'] = $this->error['title'];
        } else {
            $data['error_title'] = array();
        }

        if (isset($this->error['description'])) {
            $data['error_description'] = $this->error['description'];
        } else {
            $data['error_description'] = array();
        }

        if (isset($this->error['meta_title'])) {
            $data['error_meta_title'] = $this->error['meta_title'];
        } else {
            $data['error_meta_title'] = array();
        }

        if (isset($this->error['keyword'])) {
            $data['error_keyword'] = $this->error['keyword'];
        } else {
            $data['error_keyword'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'href'      => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true),
            'text'      => $this->language->get('text_home'),
            'separator' => false
        );

        $data['breadcrumbs'][] = array(
            'href'      => $this->url->link('catalog/sales', 'token=' . $this->session->data['token'], true),
            'text'      => $this->language->get('heading_title'),
            'separator' => ' :: '
        );

        if (!isset($this->request->get['sales_id'])) {
            $data['action'] = $this->url->link('catalog/sales/add', 'token=' . $this->session->data['token'], true);
        } else {
            $data['action'] = $this->url->link('catalog/sales/edit', 'token=' . $this->session->data['token'] . '&sales_id=' . $this->request->get['sales_id'], true);
        }

        $data['cancel'] = $this->url->link('catalog/sales', 'token=' . $this->session->data['token'], true);

        if ((isset($this->request->get['sales_id'])) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $sales_info = $this->model_catalog_sales->getSalesStory($this->request->get['sales_id']);
        }

        $this->load->model('localisation/language');

        $data['languages'] = $this->model_localisation_language->getLanguages();

        if (isset($this->request->post['sales_description'])) {
            $data['sales_description'] = $this->request->post['sales_description'];
        } elseif (isset($this->request->get['sales_id'])) {
            $data['sales_description'] = $this->model_catalog_sales->getSalesDescriptions($this->request->get['sales_id']);
        } else {
            $data['sales_description'] = array();
        }

        if (isset($this->request->post['meta_keyword'])) {
            $data['meta_keyword'] = $this->request->post['meta_keyword'];
        } elseif (isset($this->request->get['sales_id'])) {
            $data['meta_keyword'] = $this->model_catalog_sales->getSalesDescriptions($this->request->get['sales_id']);
        } else {
            $data['meta_keyword'] = array();
        }

        if (isset($this->request->post['date_start'])) {
            $data['date_start'] = $this->request->post['date_start'];
        } elseif (isset($sales_info['date_start'])) {
            $data['date_start'] = $sales_info['date_start'];
        } else {
            $data['date_start'] = date('Y-m-d');
        }

        if (isset($this->request->post['date_end'])) {
            $data['date_stdate_endart'] = $this->request->post['date_end'];
        } elseif (isset($sales_info['date_end'])) {
            $data['date_end'] = $sales_info['date_end'];
        } else {
            $data['date_end'] = date('Y-m-d');
        }

        if (isset($this->request->post['keyword'])) {
            $data['keyword'] = $this->request->post['keyword'];
        } elseif (isset($sales_info)) {
            $data['keyword'] = $sales_info['keyword'];
        } else {
            $data['keyword'] = '';
        }

        if (isset($this->request->post['image'])) {
            $data['image'] = $this->request->post['image'];
        } elseif (!empty($sales_info)) {
            $data['image'] = $sales_info['image'];
        } else {
            $data['image'] = '';
        }

        if (isset($this->request->post['thumb'])) {
            $data['thumb'] = $this->request->post['thumb'];
        } elseif (!empty($sales_info)) {
            $data['thumb'] = $sales_info['thumb'];
        } else {
            $data['thumb'] = '';
        }

        // Products
        $this->load->model('catalog/product');

        if (isset($this->request->post['sales_product'])) {
            $products = $this->request->post['sales_product'];
        } elseif (isset($this->request->get['sales_id'])) {
            $products = $this->model_catalog_sales->getSalesProducts($this->request->get['sales_id']);
        } else {
            $products = array();
        }

        $data['sales_product'] = array();

        foreach ($products as $product_id) {
            $product_info = $this->model_catalog_product->getProduct($product_id);

            if ($product_info) {
                $data['sales_product'][] = array(
                    'category_id' => $product_info['product_id'],
                    'name'        => ($product_info['path']) ? $product_info['path'] . ' &gt; ' . $product_info['name'] : $product_info['name']
                );
            }
        }

        $data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('catalog/sales_form', $data));

    }

    protected function validateForm() {
        if (!$this->user->hasPermission('modify', 'catalog/sales')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        foreach ($this->request->post['sales_description'] as $language_id => $value) {
            if ((strlen($value['title']) < 3) || (strlen($value['title']) > 255)) {
                $this->error['title'][$language_id] = $this->language->get('error_title');
            }

            if (strlen($value['description']) < 3) {
                $this->error['description'][$language_id] = $this->language->get('error_description');
            }
        }

        return !$this->error;
    }

    protected function validateDelete() {
        if (!$this->user->hasPermission('modify', 'catalog/sales')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        return !$this->error;
    }
}
