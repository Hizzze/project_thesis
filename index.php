<?php
// Version
define('VERSION', '2.3.0.2-0001.0000');

//echo md5(sha1('admin.mediaset.com.ua')); - d9745c18ac45aa5680b4fef96d7b8aee
//echo md5(sha1('admin1.mediaset.com.ua')); - e3982efb30f1023a46385c913bc37c35
// if(strpos(md5(sha1($_SERVER['HTTP_HOST'])), 'd9745c18ac45aa5680b4fef96d7b8aee') === false){
//     echo "<h1>Сайт заблокирован</h1>";
//     exit(1);
// }

$domain = '@djkal';
$regexp = '/^[a-zA-Z0-9][a-zA-Z0-9\-\_]+[a-zA-Z0-9]$/';
if (false === preg_match($regexp, $domain)) {
    exit(1);
}
// Configuration
if (is_file('config.php')) {
    require_once('config.php');
}

error_reporting(E_ALL);
ini_set("display_errors", 1);

// Install
if (!defined('DIR_APPLICATION')) {
    header('Location: install/index.php');
    exit;
}

// Startup
require_once(DIR_SYSTEM . 'startup.php');

start('catalog');