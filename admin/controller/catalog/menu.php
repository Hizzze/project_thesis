<?php
class ControllerCatalogMenu extends Controller {
    private $error = array();

    public function index() {
        $this->load->model('catalog/menu');
        $menu = $this->model_catalog_menu->getMenuByType('header');

        $data = [
            'menu' => $this->buildMenu($menu, 0)
        ];

        $data['save'] = str_replace('&amp;', '&', $this->url->link('catalog/menu/update', 'token=' . $this->session->data['token'], true));
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('design/menu', $data));
    }

    public function ua() {
        $this->load->model('catalog/menu');
        $menu = $this->model_catalog_menu->getMenuByType('header_ua');

        $data = [
            'menu' => $this->buildMenu($menu, 0)
        ];

        $data['save'] = str_replace('&amp;', '&', $this->url->link('catalog/menu/update_ua', 'token=' . $this->session->data['token'], true));
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('design/menu', $data));
    }

    public function top() {
        $this->load->model('catalog/menu');
        $menu = $this->model_catalog_menu->getMenuByType('top');

        $data = [
            'menu' => $this->buildMenu($menu, 0)
        ];

        $data['save'] = str_replace('&amp;', '&', $this->url->link('catalog/menu/update_top', 'token=' . $this->session->data['token'], true));
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('design/menu', $data));
    }

    public function top_ua() {
        $this->load->model('catalog/menu');
        $menu = $this->model_catalog_menu->getMenuByType('top_ua');

        $data = [
            'menu' => $this->buildMenu($menu, 0)
        ];

        $data['save'] = str_replace('&amp;', '&', $this->url->link('catalog/menu/update_top_ua', 'token=' . $this->session->data['token'], true));
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('design/menu', $data));
    }

    public function mobile() {
        $this->load->model('catalog/menu');
        $menu = $this->model_catalog_menu->getMenuByType('mobile');

        $data = [
            'menu' => $this->buildMenu($menu, 0)
        ];

        $data['save'] = str_replace('&amp;', '&', $this->url->link('catalog/menu/update_mobile', 'token=' . $this->session->data['token'], true));
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('design/menu', $data));
    }

    public function mobile_ua() {
        $this->load->model('catalog/menu');
        $menu = $this->model_catalog_menu->getMenuByType('mobile_ua');

        $data = [
            'menu' => $this->buildMenu($menu, 0)
        ];

        $data['save'] = str_replace('&amp;', '&', $this->url->link('catalog/menu/update_mobile_ua', 'token=' . $this->session->data['token'], true));
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('design/menu', $data));
    }

    private function buildMenu($menu, $parent_id) {
        $newMenu = [];

        $this->load->model('tool/image');
        foreach($menu as $m) {
            if($m['parent_id'] == $parent_id) {

                $tmp = [
                    'menu_id' => $m['menu_id'],
                    'text' => $m['name'],
                    'href' => $m['link'],
                ];

                if (is_file(DIR_IMAGE . $m['image'])) {
                    $tmp['thumb'] = $m['image'];
                } else {
                    $tmp['thumb'] = '';
                }

                $m2 = $this->buildMenu($menu, $m['menu_id']);
                if($m2) {
                    $tmp['children'] = $m2;
                }

                $newMenu[] = $tmp;
            }
        }
        return $newMenu;
    }

    public function update() {
        $this->load->model('catalog/menu');
        if($_POST['value']) {
            $this->model_catalog_menu->update(json_decode($_POST['value'], 1), 'header');
        }

        return true;
    }

    public function update_ua() {
        $this->load->model('catalog/menu');
        if($_POST['value']) {
            $this->model_catalog_menu->update(json_decode($_POST['value'], 1), 'header_ua');
        }

        return true;
    }

    public function update_top() {
        $this->load->model('catalog/menu');
        if($_POST['value']) {
            $this->model_catalog_menu->update(json_decode($_POST['value'], 1), 'top');
        }

        return true;
    }

    public function update_top_ua() {
        $this->load->model('catalog/menu');
        if($_POST['value']) {
            $this->model_catalog_menu->update(json_decode($_POST['value'], 1), 'top_ua');
        }

        return true;
    }

    public function update_mobile() {
        $this->load->model('catalog/menu');
        if($_POST['value']) {
            $this->model_catalog_menu->update(json_decode($_POST['value'], 1), 'mobile');
        }

        return true;
    }

    public function update_mobile_ua() {
        $this->load->model('catalog/menu');
        if($_POST['value']) {
            $this->model_catalog_menu->update(json_decode($_POST['value'], 1), 'mobile_ua');
        }

        return true;
    }
}