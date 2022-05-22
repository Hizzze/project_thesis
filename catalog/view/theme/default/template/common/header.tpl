<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><?php echo $title; ?></title>

    <?php if ($noindex) { ?>
    <!-- OCFilter Start -->
    <meta name="robots" content="noindex,nofollow"/>
    <!-- OCFilter End -->
    <?php } ?>


    <?php if ($noindex) { ?>
    <!-- OCFilter Start -->
    <meta name="robots" content="noindex,nofollow"/>
    <!-- OCFilter End -->
    <?php } ?>

    <base href="<?php echo $base; ?>"/>
    <?php if ($description) { ?>
    <meta name="description" content="<?php echo $description; ?>"/>
    <?php } ?>
    <?php if ($keywords) { ?>
    <meta name="keywords" content="<?php echo $keywords; ?>"/>
    <?php } ?>

    <link rel="stylesheet" type="text/css" href="/assets/fonts/fonts.min.css" />
    <link rel="stylesheet" type="text/css" href="/assets/css/main.min.css" />
    <link rel="stylesheet" type="text/css" href="/assets/icomoon/style.css" />
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />

    <script src="//code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
        crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>


    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script src="/catalog/view/javascript/common2.js"></script>

    <?php foreach ($styles as $style) { ?>
    <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>"
          media="<?php echo $style['media']; ?>"/>
    <?php } ?>

    <?php foreach ($links as $link) { ?>
    <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>"/>
    <?php } ?>
    <?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script; ?>" type="text/javascript"></script>
    <?php } ?>
    <?php foreach ($analytics as $analytic) { ?>
    <?php echo $analytic; ?>
    <?php } ?>

</head>
<body class="<?php echo $class; ?>">
<div class="header">
        <div class="header-top">
            <div class="container-fluid">
                <div class="header-top__i">
                    <?= $language ?>

                    <div class="header__menu">
                        <?php foreach ($topMenu as $item): ?>
                            <a href="<?php echo $item['link']; ?>"<?php if($item['target'] == '_blank') { echo ' target="_blank" '; } ?>>
                                <?php echo $item['name']; ?>
                            </a>
                        <?php endforeach; ?>
                    </div>
    
                    <div class="header-top__callback" onclick="toggleModal('callback')">
                        <span class="icon-call"></span> <?= $text['callback_header'] ?>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="container-fluid">
            <div class="header-middle">
                <div class="social-list">
                    <a href="https://t.me/converseukraine"><span class="icon-telegram"></span></a>
                    <a href="https://www.facebook.com/converseofficialua/"><span class="icon-facebook"></span></a>
                    <a href="https://instagram.com/converse.official.ua?igshid=1w5kyw1vdks26"><span class="icon-instagram"></span></a>
                </div>

                <a href="/" class="header-middle__logo">
                    <img style="height: 60px" src="/assets/img/logo.png" alt="Converse Official" />
                </a>

                <?= $cart ?>
            </div>
        </div>

        <div class="header-bottom">
    
            <div class="header-mobile-menu" onclick="toggleMenu('general')">
                <span class="icon-menu"></span>
            </div>
            
            <?= $language_mob ?>
            
            <div class="header-menu">
                <?php foreach ($menu as $item): ?>
                    <div class="header-menu-item">
                        <a href="<?php echo $item['link']; ?>"<?php if($item['target'] == '_blank') { echo ' target="_blank" '; } ?> class="header-menu-item__link">
                            <?php echo $item['name']; ?>
                        </a>
                        <?php if ($item['children']): ?>
                        <div class="header-menu-item__content">
                            <?php foreach (array_chunk($item['children'], ceil(count($item['children']) / 1)) as $children): ?>
                                <?php foreach ($children as $child): ?>
                                    <div class="header-menu-item__list">
                                        <a href="<?= $child['link'] ? $child['link'] : '#'; ?>">
                                            <span><?php echo $child['name']; ?></span>
                                            
                                            <?php if ($child['children']): ?>
                                                <?php foreach (array_chunk($child['children'], ceil(count($child['children']) / 1)) as $children2): ?>
                                                    <?php foreach ($children2 as $child2): ?>
                                                    <a href="<?= $child2['link'] ? $child2['link'] : '#'; ?>">
                                                        <span><?php echo $child2['name']; ?></span>
                                                    </a>
                                                    <?php endforeach; ?>
                                                <?php endforeach; ?>
                                            <?php endif; ?>
                                        </a>
                                    </div>
                                <?php endforeach; ?>
                            <?php endforeach; ?>
                        </div>
                        <?php endif; ?>
                    </div>
                <?php endforeach; ?>
    
                <div class="header-top__callback header-top__callback--mobile" onclick="toggleModal('callback')">
                    <span class="icon-call"></span>
                </div>

                <div class="header-search">
                    <div class="header-search__btn" onclick="toggleTopSearch()">
                        <span class="icon-search"></span>
                    </div>
                    <form class="header-search__content" method="GET" action="/search">
                        <input type="text" name="search" placeholder="<?= $text['search_placeholder'] ?>">
                        <button type="submit"><span class="icon-search"></span></button>
                    </form>
                </div>
            </div>
        </div>
    </div>