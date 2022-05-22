<?php
class ModelExtensionNews extends Model {
    public function getNews($news_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "news n LEFT JOIN " . DB_PREFIX . "news_description nd ON n.news_id = nd.news_id WHERE n.news_id = '" . (int)$news_id . "' AND nd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

        return $query->row;
    }

    public function getAllNews($data) {
        if (!empty($data['category_id'])) {
            $sql = "SELECT * FROM " . DB_PREFIX . "news_to_category n2c LEFT JOIN " . DB_PREFIX . "news n ON (n2c.news_id = n.news_id) LEFT JOIN " . DB_PREFIX . "news_description nd ON n.news_id = nd.news_id WHERE nd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND n.status = '1'  AND n2c.category_id = '" . (int)$data['category_id'] . "'";
        } else {
            $sql = "SELECT * FROM " . DB_PREFIX . "news n LEFT JOIN " . DB_PREFIX . "news_description nd ON n.news_id = nd.news_id WHERE nd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND n.status = '1'";
        }

        $sql .= " ORDER BY date_added DESC";

        if (isset($data['start']) && isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 10;
            }

            $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
        }

        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function getTotalNews() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "news");

        return $query->row['total'];
    }
}