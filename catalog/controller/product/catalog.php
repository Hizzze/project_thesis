<?php

class ControllerProductCatalog extends Controller
{
    public function index()
    {
        $this->load->language('extension/module/category');

        $data['heading_title'] = $this->language->get('heading_title');

        if (isset($this->request->get['path'])) {
            $parts = explode('_', (string)$this->request->get['path']);
        } else {
            $parts = array();
        }

        if (isset($parts[0])) {
            $data['category_id'] = $parts[0];
        } else {
            $data['category_id'] = 0;
        }

        if (isset($parts[1])) {
            $data['child_id'] = $parts[1];
        } else {
            $data['child_id'] = 0;
        }

        $this->load->model('catalog/category');

        $this->load->model('catalog/product');

        $data['categories'] = array();

        $categories = $this->model_catalog_category->getCategories(($data['child_id']) ? $data['child_id'] : $data['category_id']);

        foreach ($categories as $category) {
//			$children_data = array();

//			if ($category['category_id'] == $data['category_id']) {
//				$children = $this->model_catalog_category->getCategories($category['category_id']);
//
//				foreach($children as $child) {
//					$filter_data = array('filter_category_id' => $child['category_id'], 'filter_sub_category' => true);
//
//					$children_data[] = array(
//						'category_id' => $child['category_id'],
//						'name' => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
//						'href' => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
//					);
//				}
//			}

            $filter_data = array(
                'filter_category_id' => $category['category_id'],
                'filter_sub_category' => true
            );

            $data['categories'][] = array(
                'category_id' => $category['category_id'],
//				'name'        => $category['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
                'name' => $category['name'],
                'image' => $this->model_tool_image->resize($category['image'], 135, 125),
//				'children'    => $children_data,
                'href' => $this->url->link('product/category', 'path=' . $category['category_id'])
            );
        }

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('product/catalog', $data));

    }
}