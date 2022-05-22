<?php
class ControllerExtensionPaymentCod extends Controller {
	public function index() {
        $this->load->language('extension/payment/cod');
		$data['button_confirm'] = $this->language->get('button_confirm');

        $order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
		$data['text_loading'] = $this->language->get('text_loading');

		$data['continue'] = $this->url->link('checkout/success');

        $data['order_info'] = $order_info;
		
        $data['text'] = [
            'summary_header' => $this->language->get('summary_header'),
            'summary_name' => $this->language->get('summary_name'),
            'summary_phone' => $this->language->get('summary_phone'),
            'summary_payment' => $this->language->get('summary_payment'),
            'summary_shipping' => $this->language->get('summary_shipping'),
            'summary_email' => $this->language->get('summary_email'),
            'summary_info' => $this->language->get('summary_info'),
            'summary_pay' => $this->language->get('summary_pay'),
        ];

		return $this->load->view('extension/payment/cod', $data);
	}

	public function confirm() {
		if ($this->session->data['payment_method']['code'] == 'cod') {
			$this->load->model('checkout/order');

			$this->model_checkout_order->addOrderHistory($this->session->data['order_id'], $this->config->get('cod_order_status_id'));
		}
	}
}
