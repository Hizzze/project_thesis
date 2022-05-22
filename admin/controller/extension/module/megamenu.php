<?php

class ControllerExtensionModuleMegamenu extends Controller {
    public function index() {
        $this->response->redirect($this->url->link('module/megamenu', 'token=' . $this->session->data['token'], true));
    }
}