<?php
class ModelCatalogMenu extends Model {
    public function getMenuByType($type)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "menu m LEFT JOIN " . DB_PREFIX . "menu_description md ON (m.menu_id = md.menu_id) WHERE type = '" . $this->db->escape($type) . "' AND md.language_id = '14' AND m.store_id = '" . (int)$this->config->get('config_store_id') . "' AND m.status = '1' ORDER BY m.menu_id ASC");

        return $query->rows;
    }

    public function update($data, $type) {
        $ids = $this->db->query("SELECT menu_id FROM " . DB_PREFIX . "menu WHERE type = '" . $this->db->escape($type) . "'");
        if(count($ids->rows)) {
            $list = [];
            foreach($ids->rows as $id) {
                $list[] = $id['menu_id'];
            }

            $this->db->query("DELETE FROM " . DB_PREFIX . "menu WHERE menu_id IN(" . implode(',', $list) . ")");
            $this->db->query("DELETE FROM " . DB_PREFIX . "menu_description WHERE menu_id IN(" . implode(',', $list) . ")");
        }

        foreach($data as $item) {
            $this->upload($item, 0, $type);
        }

        return true;
    }

    private function upload($item, $parent_id = 0, $type) {
        $this->db->query("INSERT INTO " . DB_PREFIX . "menu SET store_id = 0, type = '" . $this->db->escape($type) . "', parent_id = " . $parent_id . ", link = '" . $this->db->escape($item['href']) . "', target = '" . $this->db->escape($item['target']) . "', image = '" . $this->db->escape($item['thumb']) . "', status = 1");

        $menu_id = $this->db->getLastId();

        $this->db->query("INSERT INTO " . DB_PREFIX . "menu_description SET language_id = 14, menu_id = " . $menu_id . ", name = '" . $this->db->escape($item['text']) . "'");

        if(isset($item['children']) && count($item['children']) > 0) {
            foreach($item['children'] as $child) {
                $this->upload($child, $menu_id, $type);
            }
        }
    }
}
