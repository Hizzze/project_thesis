<?php

class ModelDesignMenu extends Model
{
    public function getMenuByType($type)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "menu m LEFT JOIN " . DB_PREFIX . "menu_description md ON (m.menu_id = md.menu_id) WHERE type = '" . $this->db->escape($type) . "' AND md.language_id = '14' AND m.store_id = '" . (int)$this->config->get('config_store_id') . "' AND m.status = '1' ORDER BY m.menu_id ASC");

        return $query->rows;
    }
}