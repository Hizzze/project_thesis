<?php
class ControllerExtensionShippingAustralia extends Controller {
    private $error = array();

    public function index() {
        $this->load->language('extension/shipping/australia');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('australia', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=shipping', true));
        }

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_all_zones'] = $this->language->get('text_all_zones');
        $data['text_none'] = $this->language->get('text_none');

        $data['entry_cost'] = $this->language->get('entry_cost');
        $data['entry_total'] = $this->language->get('entry_total');
        $data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
        $data['entry_status'] = $this->language->get('entry_status');
        $data['entry_sort_order'] = $this->language->get('entry_sort_order');

        $data['help_total'] = $this->language->get('help_total');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_extension'),
            'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=shipping', true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/shipping/australia', 'token=' . $this->session->data['token'], true)
        );

        $data['action'] = $this->url->link('extension/shipping/australia', 'token=' . $this->session->data['token'], true);

        $data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=shipping', true);

        if (isset($this->request->post['australia_cost'])) {
            $data['australia_cost'] = $this->request->post['australia_cost'];
        } else {
            $data['australia_cost'] = $this->config->get('australia_cost');
        }

        if (isset($this->request->post['australia_total'])) {
            $data['australia_total'] = $this->request->post['australia_total'];
        } else {
            $data['australia_total'] = $this->config->get('australia_total');
        }

        if (isset($this->request->post['australia_geo_zone_id'])) {
            $data['australia_geo_zone_id'] = $this->request->post['australia_geo_zone_id'];
        } else {
            $data['australia_geo_zone_id'] = $this->config->get('australia_geo_zone_id');
        }

        $this->load->model('localisation/geo_zone');

        $data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

        if (isset($this->request->post['australia_status'])) {
            $data['australia_status'] = $this->request->post['australia_status'];
        } else {
            $data['australia_status'] = $this->config->get('australia_status');
        }

        if (isset($this->request->post['australia_sort_order'])) {
            $data['australia_sort_order'] = $this->request->post['australia_sort_order'];
        } else {
            $data['australia_sort_order'] = $this->config->get('australia_sort_order');
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/shipping/australia', $data));
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/shipping/australia')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        return !$this->error;
    }
}