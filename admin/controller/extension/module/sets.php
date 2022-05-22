<?php ${"GLOBALS"}["yxgnuewfcwx"] = "data";
${"GLOBALS"}["uernosho"] = "sets";
${"GLOBALS"}["qhurudaudzwz"] = "s";
${"GLOBALS"}["onqjnols"] = "options";
${"GLOBALS"}["ideurdx"] = "product_option_value";
${"GLOBALS"}["wthfbco"] = "product_option_value_data";
${"GLOBALS"}["mrdiocmnht"] = "option_info";
${"GLOBALS"}["rufqicjfem"] = "product_option";
${"GLOBALS"}["lcdjtnw"] = "product_options";
${"GLOBALS"}["dfpmktnltly"] = "id";
${"GLOBALS"}["lwmyejsnn"] = "option_data";
${"GLOBALS"}["utomcmvp"] = "filter_name";
${"GLOBALS"}["edpdvkjt"] = "filter_data";
${"GLOBALS"}["fwiyxhssuq"] = "limit";
${"GLOBALS"}["kxyzrmvrlth"] = "filter_model";
${"GLOBALS"}["jepusbhde"] = "json";
${"GLOBALS"}["ythdbauxgy"] = "result";
${"GLOBALS"}["rbfjmo"] = "sets_html";
${"GLOBALS"}["ggkqslw"] = "datas";
${"GLOBALS"}["pgtvstwvnens"] = "newline_symbols";
${"GLOBALS"}["ffdrptn"] = "form";
${"GLOBALS"}["rocbqywaedp"] = "pri";
${"GLOBALS"}["lpsjfflmvslr"] = "key";
${"GLOBALS"}["nyqvuvqnwbm"] = "set_clear_from_text";
${"GLOBALS"}["vnpaacx"] = "set_tab";
${"GLOBALS"}["wzmlecr"] = "price";
${"GLOBALS"}["ehfuunidpb"] = "special";
${"GLOBALS"}["gleuhxrmse"] = "product_special";
${"GLOBALS"}["blvlihgm"] = "product_specials";
${"GLOBALS"}["lyejhxt"] = "set_clear_from";
${"GLOBALS"}["nprbzzum"] = "product_info";
${"GLOBALS"}["uswibkxq"] = "query";

class ControllerExtensionModuleSets extends Controller
{
    private $error = array();

    public function install()
    {
        ${${"GLOBALS"}["uswibkxq"]} = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "product` LIKE 'sets';");
        if (!$query->rows) $this->db->query("ALTER TABLE `" . DB_PREFIX . "product` ADD `sets` text NULL;");
    }

    public function selectModel()
    {
        if (floatval(VERSION) >= 2.2 && file_exists(DIR_CATALOG . "model/total/set22.php")) {
            if (file_exists(DIR_CATALOG . "model/total/set.php")) unlink(DIR_CATALOG . "model/total/set.php");
            if (file_exists(DIR_CATALOG . "model/total/set21.php")) unlink(DIR_CATALOG . "model/total/set21.php");
            rename(DIR_CATALOG . "model/total/set22.php", DIR_CATALOG . "model/total/set.php");
        } else if (floatval(VERSION) < 2.2 && file_exists(DIR_CATALOG . "model/total/set21.php")) {
            if (file_exists(DIR_CATALOG . "model/total/set.php")) unlink(DIR_CATALOG . "model/total/set.php");
            if (file_exists(DIR_CATALOG . "model/total/set22.php")) unlink(DIR_CATALOG . "model/total/set22.php");
            rename(DIR_CATALOG . "model/total/set21.php", DIR_CATALOG . "model/total/set.php");
        }
    }

    public function getSetsForm()
    {
        $bumpcenpiub = "set_clear_from_text";
        $xkiquqmg = "newline_symbols";
        ${"GLOBALS"}["hnorjhztdt"] = "set_clear_from_text";
        ${"GLOBALS"}["ehttoo"] = "newline_symbols";
        ${"GLOBALS"}["kcbofi"] = "result";
        $gfvtndmq = "set_tab";
        ${"GLOBALS"}["gednihrmvk"] = "set_clear_from_text";
        ${$xkiquqmg} = array("\r", "\n");
        ${"GLOBALS"}["afvyoippdt"] = "set_tab";
        $eybgjwipxipx = "product_info";
        $this->load->language("extension/module/sets");
        if (isset($this->request->get["product_id"]) && ($this->request->server["REQUEST_METHOD"] != "POST")) {
            ${${"GLOBALS"}["nprbzzum"]} = $this->model_catalog_product->getProduct($this->request->get["product_id"]);
        }
        ${"GLOBALS"}["muwgboinecg"] = "set_tab";
        ${"GLOBALS"}["lpiojyf"] = "set_clear_from";
        if (isset(${$eybgjwipxipx})) {
            ${"GLOBALS"}["gaymdhxqgk"] = "set_clear_from";
            $qwwjruvde = "price";
            $fziqsab = "special";
            $wmuskci = "set_tab";
            ${"GLOBALS"}["ejlsikgufhf"] = "special";
            ${${"GLOBALS"}["lyejhxt"]}["product_name"] = ${${"GLOBALS"}["nprbzzum"]}["name"];
            $puqyqgtqkea = "product_info";
            ${${"GLOBALS"}["ejlsikgufhf"]} = false;
            ${${"GLOBALS"}["blvlihgm"]} = $this->model_catalog_product->getProductSpecials(${${"GLOBALS"}["nprbzzum"]}["product_id"]);
            foreach (${${"GLOBALS"}["blvlihgm"]} as ${${"GLOBALS"}["gleuhxrmse"]}) {
                $ogskcyq = "product_special";
                if ((${$ogskcyq}["date_start"] == "0000-00-00" || strtotime(${${"GLOBALS"}["gleuhxrmse"]}["date_start"]) < time()) && (${${"GLOBALS"}["gleuhxrmse"]}["date_end"] == "0000-00-00" || strtotime(${${"GLOBALS"}["gleuhxrmse"]}["date_end"]) > time())) {
                    ${${"GLOBALS"}["ehfuunidpb"]} = ${${"GLOBALS"}["gleuhxrmse"]}["price"];
                    break;
                }
            }
            $dtialrhqq = "product_info";
            if (${${"GLOBALS"}["ehfuunidpb"]}) ${${"GLOBALS"}["wzmlecr"]} = ${$fziqsab}; else${$qwwjruvde} = ${${"GLOBALS"}["nprbzzum"]}["price"];
            ${${"GLOBALS"}["gaymdhxqgk"]}["product_id"] = ${$puqyqgtqkea}["product_id"];
            ${${"GLOBALS"}["lyejhxt"]}["options"] = $this->getOptProduct(${${"GLOBALS"}["nprbzzum"]}["product_id"]);
            ${$wmuskci}["product_id"] = ${$dtialrhqq}["product_id"];
        } else {
            ${"GLOBALS"}["tlwmyt"] = "set_clear_from";
            ${${"GLOBALS"}["tlwmyt"]}["product_name"] = "";
            ${${"GLOBALS"}["lyejhxt"]}["product_id"] = 0;
            ${${"GLOBALS"}["lyejhxt"]}["options"] = array();
            ${${"GLOBALS"}["vnpaacx"]}["product_id"] = 0;
        }
        ${${"GLOBALS"}["nyqvuvqnwbm"]}["entry_product_name"] = $this->language->get("entry_name");
        ${"GLOBALS"}["jgoulggv"] = "newline_symbols";
        ${${"GLOBALS"}["gednihrmvk"]}["entry_product_quantity"] = $this->language->get("entry_quantity");
        ${${"GLOBALS"}["hnorjhztdt"]}["entry_discount"] = $this->language->get("entry_discount");
        ${"GLOBALS"}["gijmvinb"] = "set_tab";
        ${"GLOBALS"}["chgkipuyref"] = "product_info";
        ${${"GLOBALS"}["nyqvuvqnwbm"]}["entry_product_options"] = $this->language->get("entry_options");
        ${${"GLOBALS"}["gijmvinb"]}["entry_add_set"] = $this->language->get("entry_add_set");
        ${"GLOBALS"}["fuolpep"] = "set_clear_from";
        ${${"GLOBALS"}["afvyoippdt"]}["entry_save_sets"] = $this->language->get("entry_save_sets");
        ${${"GLOBALS"}["lyejhxt"]} = array_merge(${${"GLOBALS"}["lyejhxt"]}, ${$bumpcenpiub});
        if (!empty(${${"GLOBALS"}["chgkipuyref"]}["sets"])) {
            ${"GLOBALS"}["qfkgojs"] = "set";
            ${"GLOBALS"}["fyeynsvshf"] = "set_tab";
            $oxcwgwug = "sets";
            ${$oxcwgwug} = json_decode(${${"GLOBALS"}["nprbzzum"]}["sets"], true);
            ${"GLOBALS"}["mneiykew"] = "sets_html";
            $ktogsntwqwk = "sets";
            ${${"GLOBALS"}["mneiykew"]} = "";
            foreach (${$ktogsntwqwk} as ${${"GLOBALS"}["lpsjfflmvslr"]} => ${${"GLOBALS"}["qfkgojs"]}) {
                $suvkfjrbxhm = "pr";
                ${"GLOBALS"}["kwqqtn"] = "set";
                ${"GLOBALS"}["kebggooro"] = "sets_html";
                ${"GLOBALS"}["jxmxkxjnsqf"] = "datas";
                ${"GLOBALS"}["axtlicaug"] = "pr";
                ${"GLOBALS"}["olwfsxygwf"] = "pr";
                ${"GLOBALS"}["tegypmnblhp"] = "key";
                ${"GLOBALS"}["wgaoyfv"] = "set";
                ${"GLOBALS"}["dodumfwnvv"] = "set";
                foreach (${${"GLOBALS"}["wgaoyfv"]}["products"] as ${${"GLOBALS"}["rocbqywaedp"]} => &${${"GLOBALS"}["axtlicaug"]}) ${${"GLOBALS"}["olwfsxygwf"]}["options"] = $this->getOptProduct(${$suvkfjrbxhm}["product_id"]);
                ${${"GLOBALS"}["kwqqtn"]}["key"] = ${${"GLOBALS"}["tegypmnblhp"]};
                ${${"GLOBALS"}["jxmxkxjnsqf"]} = array_merge(${${"GLOBALS"}["dodumfwnvv"]}, ${${"GLOBALS"}["nyqvuvqnwbm"]});
                if (floatval(VERSION) >= 2.2) ${${"GLOBALS"}["ffdrptn"]} = str_replace(${${"GLOBALS"}["pgtvstwvnens"]}, "", $this->load->view("extension/module/sets/set_form", ${${"GLOBALS"}["ggkqslw"]})); else${${"GLOBALS"}["ffdrptn"]} = str_replace(${${"GLOBALS"}["pgtvstwvnens"]}, "", $this->load->view("extension/module/sets/set_form.tpl", ${${"GLOBALS"}["ggkqslw"]}));
                ${${"GLOBALS"}["kebggooro"]} .= ${${"GLOBALS"}["ffdrptn"]};
            }
            ${${"GLOBALS"}["fyeynsvshf"]}["sets"] = ${${"GLOBALS"}["rbfjmo"]};
        }
        ${${"GLOBALS"}["vnpaacx"]}["token"] = $this->session->data["token"];
        if (floatval(VERSION) >= 2.2) ${${"GLOBALS"}["vnpaacx"]}["set_row"] = str_replace(${${"GLOBALS"}["pgtvstwvnens"]}, "", $this->load->view("extension/module/sets/set_row", array())); else${${"GLOBALS"}["vnpaacx"]}["set_row"] = str_replace(${${"GLOBALS"}["pgtvstwvnens"]}, "", $this->load->view("extension/module/sets/set_row.tpl", array()));
        if (floatval(VERSION) >= 2.2) ${${"GLOBALS"}["muwgboinecg"]}["set_clear_form"] = str_replace(${${"GLOBALS"}["ehttoo"]}, "", $this->load->view("extension/module/sets/set_clear_form", ${${"GLOBALS"}["lpiojyf"]})); else${${"GLOBALS"}["vnpaacx"]}["set_clear_form"] = str_replace(${${"GLOBALS"}["pgtvstwvnens"]}, "", $this->load->view("extension/module/sets/set_clear_form.tpl", ${${"GLOBALS"}["fuolpep"]}));
        if (floatval(VERSION) >= 2.2) ${${"GLOBALS"}["ythdbauxgy"]} = str_replace(${${"GLOBALS"}["jgoulggv"]}, "", $this->load->view("extension/module/sets/set_tab", ${$gfvtndmq})); else${${"GLOBALS"}["ythdbauxgy"]} = str_replace(${${"GLOBALS"}["pgtvstwvnens"]}, "", $this->load->view("extension/module/sets/set_tab.tpl", ${${"GLOBALS"}["vnpaacx"]}));
        return ${${"GLOBALS"}["kcbofi"]};
    }

    public function optionsForms()
    {
        if ($this->request->post["options"]) {
            if (floatval(VERSION) >= 2.2) echo $this->load->view("extension/module/sets/set_product_opt", $this->request->post); else echo $this->load->view("extension/module/sets/set_product_opt.tpl", $this->request->post);
        }
    }

    public function autocomplete()
    {
        ${${"GLOBALS"}["jepusbhde"]} = array();
        if (isset($this->request->get["filter_name"]) || isset($this->request->get["filter_model"])) {
            ${"GLOBALS"}["jhmnlgmhl"] = "limit";
            $this->load->model("catalog/product");
            $this->load->model("catalog/option");
            ${"GLOBALS"}["jxdqhwoy"] = "result";
            $ypjdgbwgsr = "results";
            if (isset($this->request->get["filter_name"])) {
                $yrvydayisryp = "filter_name";
                ${$yrvydayisryp} = $this->request->get["filter_name"];
            } else {
                $edblwqncb = "filter_name";
                ${$edblwqncb} = "";
            }
            ${"GLOBALS"}["qescpfw"] = "filter_model";
            $kfyjakccoe = "filter_data";
            ${"GLOBALS"}["jhldsfxenn"] = "results";
            if (isset($this->request->get["filter_model"])) {
                ${"GLOBALS"}["ldmxjyrnc"] = "filter_model";
                ${${"GLOBALS"}["ldmxjyrnc"]} = $this->request->get["filter_model"];
            } else {
                ${${"GLOBALS"}["kxyzrmvrlth"]} = "";
            }
            if (isset($this->request->get["limit"])) {
                ${${"GLOBALS"}["fwiyxhssuq"]} = $this->request->get["limit"];
            } else {
                ${"GLOBALS"}["ovkeonbdlnt"] = "limit";
                ${${"GLOBALS"}["ovkeonbdlnt"]} = 5;
            }
            ${${"GLOBALS"}["edpdvkjt"]} = array("filter_name" => ${${"GLOBALS"}["utomcmvp"]}, "filter_model" => ${${"GLOBALS"}["qescpfw"]}, "start" => 0, "limit" => ${${"GLOBALS"}["jhmnlgmhl"]});
            ${$ypjdgbwgsr} = $this->model_catalog_product->getProducts(${$kfyjakccoe});
            foreach (${${"GLOBALS"}["jhldsfxenn"]} as ${${"GLOBALS"}["jxdqhwoy"]}) {
                $fjoexwzvjr = "result";
                ${"GLOBALS"}["odopsvyojg"] = "result";
                $cuzrtkht = "result";
                ${${"GLOBALS"}["lwmyejsnn"]} = $this->getOptProduct(${${"GLOBALS"}["odopsvyojg"]}["product_id"]);
                ${${"GLOBALS"}["jepusbhde"]}[] = array("product_id" => ${${"GLOBALS"}["ythdbauxgy"]}["product_id"], "name" => strip_tags(html_entity_decode(${$fjoexwzvjr}["name"], ENT_QUOTES, "UTF-8")), "model" => ${$cuzrtkht}["model"], "option" => ${${"GLOBALS"}["lwmyejsnn"]}, "price" => ${${"GLOBALS"}["ythdbauxgy"]}["price"]);
            }
        }
        $this->response->addHeader("Content-Type: application/json");
        $this->response->setOutput(json_encode(${${"GLOBALS"}["jepusbhde"]}));
    }

    public function getOptProduct($id)
    {
        ${"GLOBALS"}["cmzflcykia"] = "options";
        ${${"GLOBALS"}["cmzflcykia"]} = array();
        $this->load->model("tool/image");
        ${"GLOBALS"}["wlbizbtof"] = "product_options";
        ${"GLOBALS"}["lmlddsgdzwr"] = "options";
        $this->load->model("catalog/option");
        ${${"GLOBALS"}["wlbizbtof"]} = $this->model_catalog_product->getProductOptions(${${"GLOBALS"}["dfpmktnltly"]});
        foreach (${${"GLOBALS"}["lcdjtnw"]} as ${${"GLOBALS"}["rufqicjfem"]}) {
            $imrdgbzuxp = "option_info";
            $lrzcckjx = "product_option";
            ${$imrdgbzuxp} = $this->model_catalog_option->getOption(${$lrzcckjx}["option_id"]);
            if (${${"GLOBALS"}["mrdiocmnht"]}) {
                ${"GLOBALS"}["zrekhyokontq"] = "product_option";
                ${"GLOBALS"}["mrjgmirtgtni"] = "option_info";
                ${"GLOBALS"}["tcpjhciniv"] = "product_option";
                $nvivqwltdicx = "product_option_value_data";
                ${${"GLOBALS"}["wthfbco"]} = array();
                ${"GLOBALS"}["nnkzjfduyfm"] = "product_option";
                ${"GLOBALS"}["phbedtd"] = "option_info";
                foreach (${${"GLOBALS"}["rufqicjfem"]}["product_option_value"] as ${${"GLOBALS"}["ideurdx"]}) {
                    $lescqsvba = "option_value_info";
                    ${"GLOBALS"}["jucgqdbnovh"] = "option_value_info";
                    ${$lescqsvba} = $this->model_catalog_option->getOptionValue(${${"GLOBALS"}["ideurdx"]}["option_value_id"]);
                    if (${${"GLOBALS"}["jucgqdbnovh"]}) {
                        ${"GLOBALS"}["jqlgbgjfds"] = "product_option_value";
                        $tvlpknmk = "product_option_value";
                        $nfoqsj = "option_value_info";
                        $widfyihvl = "option_value_info";
                        $pkwfdcqlhr = "product_option_value_data";
                        ${$pkwfdcqlhr}[] = array("product_option_value_id" => ${$tvlpknmk}["product_option_value_id"], "option_value_id" => ${${"GLOBALS"}["ideurdx"]}["option_value_id"], "image" => $this->model_tool_image->resize(${$widfyihvl}["image"], 50, 50), "name" => ${$nfoqsj}["name"], "price" => (float)${${"GLOBALS"}["ideurdx"]}["price"] ? $this->currency->format(${${"GLOBALS"}["jqlgbgjfds"]}["price"], $this->config->get("config_currency")) : false, "price_prefix" => ${${"GLOBALS"}["ideurdx"]}["price_prefix"]);
                    }
                }
                ${${"GLOBALS"}["onqjnols"]}[] = array("product_option_id" => ${${"GLOBALS"}["zrekhyokontq"]}["product_option_id"], "product_option_value" => ${$nvivqwltdicx}, "option_id" => ${${"GLOBALS"}["tcpjhciniv"]}["option_id"], "name" => ${${"GLOBALS"}["phbedtd"]}["name"], "type" => ${${"GLOBALS"}["mrjgmirtgtni"]}["type"], "value" => ${${"GLOBALS"}["rufqicjfem"]}["value"], "required" => ${${"GLOBALS"}["nnkzjfduyfm"]}["required"]);
            }
        }
        return ${${"GLOBALS"}["lmlddsgdzwr"]};
    }

    public function saveSets()
    {
        $this->load->language("extension/module/sets");
        ${"GLOBALS"}["oihnqocezf"] = "json";
        ${${"GLOBALS"}["jepusbhde"]} = array();
        if (!$this->user->hasPermission("modify", "extension/module/sets")) {
            ${${"GLOBALS"}["jepusbhde"]}["error"] = $this->language->get("error_permission");
        } else if (empty($this->request->post["product_id"])) {
            ${${"GLOBALS"}["jepusbhde"]}["error"] = $this->language->get("error_new_prod");
        } else if (isset($this->request->post["set"]) && is_array($this->request->post["set"]) && count($this->request->post["set"])) {
            foreach ($this->request->post["set"] as ${${"GLOBALS"}["qhurudaudzwz"]}) {
                $cwoffrbyct = "s";
                if (count(${$cwoffrbyct}["products"]) <= 1) ${${"GLOBALS"}["jepusbhde"]}["error"] = $this->language->get("error_count_prod");
            }
        }
        if (!isset(${${"GLOBALS"}["oihnqocezf"]}["error"])) {
            ${"GLOBALS"}["rosqixvrt"] = "sets";
            ${${"GLOBALS"}["rosqixvrt"]} = "";
            if (isset($this->request->post["set"])) ${${"GLOBALS"}["uernosho"]} = json_encode($this->request->post["set"], JSON_UNESCAPED_UNICODE | JSON_HEX_QUOT);
            $this->db->query("UPDATE " . DB_PREFIX . "product SET sets = '" . ${${"GLOBALS"}["uernosho"]} . "' WHERE product_id = '" . (int)$this->request->post["product_id"] . "'");
            ${${"GLOBALS"}["jepusbhde"]}["success"] = $this->language->get("entry_save");
        }
        $this->response->addHeader("Content-Type: application/json");
        $this->response->setOutput(json_encode(${${"GLOBALS"}["jepusbhde"]}));
    }

    public function index()
    {
        ${"GLOBALS"}["otjcxuurcq"] = "data";
        $ucconexh = "data";
        $this->selectModel();
        $zfdqbgnqu = "data";
        $this->load->language("extension/module/sets");
        $this->document->setTitle($this->language->get("heading_title"));
        $this->load->model("setting/setting");
        ${"GLOBALS"}["lsmhuef"] = "data";
        $lihvxwil = "data";
        $uwxonotjkb = "data";
        $igwpmq = "data";
        ${"GLOBALS"}["vscllkt"] = "data";
        if (($this->request->server["REQUEST_METHOD"] == "POST") && $this->validate()) {
            $this->model_setting_setting->editSetting("sets", $this->request->post);
            $this->session->data["success"] = $this->language->get("text_success");
            $this->response->redirect($this->url->link("extension/extension", "token=" . $this->session->data["token"] . "&type=module", true));
        }
        ${${"GLOBALS"}["lsmhuef"]}["heading_title"] = $this->language->get("heading_title");
        ${"GLOBALS"}["ubvnww"] = "data";
        ${${"GLOBALS"}["otjcxuurcq"]}["text_info"] = $this->language->get("text_info");
        ${${"GLOBALS"}["yxgnuewfcwx"]}["text_before"] = $this->language->get("text_before");
        $ejlsfpfudm = "data";
        $iqfpyzq = "data";
        ${${"GLOBALS"}["yxgnuewfcwx"]}["text_after"] = $this->language->get("text_after");
        ${$ucconexh}["text_edit"] = $this->language->get("text_edit");
        ${"GLOBALS"}["ogbdjnip"] = "data";
        ${${"GLOBALS"}["yxgnuewfcwx"]}["text_enabled"] = $this->language->get("text_enabled");
        ${$uwxonotjkb}["text_disabled"] = $this->language->get("text_disabled");
        ${${"GLOBALS"}["vscllkt"]}["entry_key"] = $this->language->get("entry_key");
        ${${"GLOBALS"}["yxgnuewfcwx"]}["entry_status"] = $this->language->get("entry_status");
        ${${"GLOBALS"}["yxgnuewfcwx"]}["entry_show_qty"] = $this->language->get("entry_show_qty");
        ${${"GLOBALS"}["yxgnuewfcwx"]}["entry_position"] = $this->language->get("entry_position");
        ${${"GLOBALS"}["yxgnuewfcwx"]}["entry_selector"] = $this->language->get("entry_selector");
        ${${"GLOBALS"}["ogbdjnip"]}["button_save"] = $this->language->get("button_save");
        ${${"GLOBALS"}["yxgnuewfcwx"]}["button_cancel"] = $this->language->get("button_cancel");
        $ivdbbjwbh = "data";
        ${"GLOBALS"}["abximmk"] = "data";
        if (isset($this->error["warning"])) {
            ${${"GLOBALS"}["yxgnuewfcwx"]}["error_warning"] = $this->error["warning"];
        } else {
            $jkpdtwbv = "data";
            ${$jkpdtwbv}["error_warning"] = "";
        }
        ${"GLOBALS"}["motcqpu"] = "data";
        ${$ejlsfpfudm}["breadcrumbs"] = array();
        $wjusfmdd = "data";
        $etnlrrrfyes = "data";
        ${${"GLOBALS"}["yxgnuewfcwx"]}["breadcrumbs"][] = array("text" => $this->language->get("text_home"), "href" => $this->url->link("common/dashboard", "token=" . $this->session->data["token"], true));
        ${"GLOBALS"}["rioxtr"] = "data";
        ${$wjusfmdd}["breadcrumbs"][] = array("text" => $this->language->get("text_module"), "href" => $this->url->link("extension/module", "token=" . $this->session->data["token"], true));
        ${${"GLOBALS"}["yxgnuewfcwx"]}["breadcrumbs"][] = array("text" => $this->language->get("heading_title"), "href" => $this->url->link("extension/module/sets", "token=" . $this->session->data["token"], true));
        ${${"GLOBALS"}["motcqpu"]}["action"] = $this->url->link("extension/module/sets", "token=" . $this->session->data["token"], true);
        ${$zfdqbgnqu}["cancel"] = $this->url->link("extension/extension", "token=" . $this->session->data["token"] . "&type=module", true);
        if (isset($this->request->post["sets_show_disc_prec"])) ${${"GLOBALS"}["yxgnuewfcwx"]}["sets_show_disc_prec"] = $this->request->post["sets_show_disc_prec"]; else${${"GLOBALS"}["yxgnuewfcwx"]}["sets_show_disc_prec"] = $this->config->get("sets_show_disc_prec");
        if (isset($this->request->post["sets_show_qty"])) ${${"GLOBALS"}["yxgnuewfcwx"]}["sets_show_qty"] = $this->request->post["sets_show_qty"]; else${${"GLOBALS"}["yxgnuewfcwx"]}["sets_show_qty"] = $this->config->get("sets_show_qty");
        if (isset($this->request->post["sets_status"])) ${$etnlrrrfyes}["sets_status"] = $this->request->post["sets_status"]; else${${"GLOBALS"}["yxgnuewfcwx"]}["sets_status"] = $this->config->get("sets_status");
        if (isset($this->request->post["sets_key"])) ${${"GLOBALS"}["yxgnuewfcwx"]}["sets_key"] = $this->request->post["sets_key"]; else${$ivdbbjwbh}["sets_key"] = $this->config->get("sets_key");
        if (isset($this->request->post["sets_position"])) ${${"GLOBALS"}["yxgnuewfcwx"]}["sets_position"] = $this->request->post["sets_position"]; else${${"GLOBALS"}["yxgnuewfcwx"]}["sets_position"] = $this->config->get("sets_position");
        if (isset($this->request->post["sets_selector"])) ${${"GLOBALS"}["yxgnuewfcwx"]}["sets_selector"] = $this->request->post["sets_selector"]; else if ($this->config->get("sets_selector")) ${$igwpmq}["sets_selector"] = $this->config->get("sets_selector"); else${${"GLOBALS"}["ubvnww"]}["sets_selector"] = "#content";
        ${${"GLOBALS"}["abximmk"]}["header"] = $this->load->controller("common/header");
        ${${"GLOBALS"}["yxgnuewfcwx"]}["column_left"] = $this->load->controller("common/column_left");
        ${$lihvxwil}["footer"] = $this->load->controller("common/footer");
        if (floatval(VERSION) >= 2.2) $this->response->setOutput($this->load->view("extension/module/sets/sets", ${$iqfpyzq})); else$this->response->setOutput($this->load->view("extension/module/sets/sets.tpl", ${${"GLOBALS"}["rioxtr"]}));
    }

    protected function validate()
    {
        if (!$this->user->hasPermission("modify", "extension/module/sets")) {
            $this->error["warning"] = $this->language->get("error_permission");
        }
        return !$this->error;
    }
} ?>