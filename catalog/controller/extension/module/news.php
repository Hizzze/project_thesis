<?php  
class ControllerExtensionModuleNews extends Controller {
	public function index() {
		$this->language->load('extension/module/news');
		$this->load->model('extension/news');
		
		$filter_data = array(
			'page' => 1,
			'limit' => 2,
			'start' => 0,
		);
	 
		$data['heading_title'] = $this->language->get('heading_title');
	 
		$all_news = $this->model_extension_news->getAllNews($filter_data);

        $data['all_news'] = array();

        $this->load->model('tool/image');

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

        $data['text_show_all'] = $this->language->get('text_show_all_news');
        $data['text']['blog_header'] = $this->language->get('blog_header');
		
		return $this->load->view('extension/module/news', $data);
	}
}