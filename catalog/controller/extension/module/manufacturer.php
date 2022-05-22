<?php
class ControllerExtensionModuleManufacturer extends Controller {
    public function index() {
        $this->load->language('extension/module/manufacturer');

        $data['heading_title'] = $this->language->get('heading_title');

        $this->load->model('catalog/manufacturer');
        $this->load->model('catalog/product');

        $data['manufacturers'] = array();

        $data = $this->model_catalog_manufacturer->getManufacturers();

        foreach ($data as $item) {
            $data['manufacturers'][] = array(
                'manufacturer_id' => $item['manufacturer_id'],
                'name'        => $item['name'],
                'href'        => $this->url->link('product/manufacturer', 'path=' . $item['category_id'])
            );
        }

        return $this->load->view('extension/module/manufacturer', $data);
    }
}