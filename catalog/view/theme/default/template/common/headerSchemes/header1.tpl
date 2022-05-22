<div class="header-wrapper header-wrapper--type2">
    <div class="top_line">
        <div class="llllang">
            <?php echo $language; ?>
        </div>
        <div class="container">
            <div class="top_line__inner">
                <div class="top_line-soc">
                    <a href="#">
                        <i class="fa fa-facebook" aria-hidden="true"></i>
                    </a>
                    <a href="#">
                        <i class="fa fa-twitter" aria-hidden="true"></i>
                    </a>
                    <a href="#">
                        <i class="fa fa-google-plus " aria-hidden="true"></i>
                    </a>
                </div>
                <div class="top_line-links">
                    <?php echo $search; ?>
                    <a href="/about_us">О магазине</a>
                    <a href="/uslugi">Услуги</a>
                    <a href="/contacts">Контакты</a>
                    <a href="/akcii">Акции</a>
                    <a href="/oplata-i-dostavka">Оплата и доставка</a>
                    <?php if ($logged) { ?>
                    <a href="<?php echo $account; ?>" class="header__user-span"><i class="fa fa-user"></i>
                        <span><?= $customer ?></span></a>
                    <?php } else { ?>
                    <a href="<?php echo $login; ?>" class="header__user-span"><i class="fa fa-user"></i>
                        <span><?= $text['header_enter'] ?> <!-- Р’РѕР№С‚Рё РІ Р»РёС‡РЅС‹Р№ РєР°Р±РёРЅРµС‚ --></span></a>
                    <?php } ?>
                    <!--           <?php if ($logged) { ?>
                              <a href="<?php echo $account; ?>" class="header__user-span"><?= $customer ?></a>
                              <?php } else { ?>
                              <a href="<?php echo $login; ?>" class="header__user-span"><?= $text['header_enter'] ?></a>
                              <?php } ?> -->
                </div>
            </div>
        </div>
    </div>
    <header id="header">
        <div class="container">
            <div class="row-header-flex row relative_block hidden-sm hidden-xs">
                <div class="col-md-2 head_logo">
                    <a href="/">
                        <img src="<?= $logo ?>" alt="logo"/>
                    </a>
                </div>
                <div class="col-md-7 header__phones">
                    <div class="head-place">
                        <img src="/catalog/view/theme/default/image/placeholder.svg" alt="place"/>
                        <p>г. Киев, Проспект 50Д</p>
                    </div>
                    <div>
                        <a href="tel:+380509224783">+38 (050) 922-47-83</a>
                        <a href="tel:+380675911188">+38 (067) 591-11-88 </a>
                    </div>
                    <?= $open ?>
                </div>
                <div class="col-md-2 head_right">

                    <a id="compare" href="<?= $compare ?>" title="<?= $text['header_compare'] ?>"
                       class="header-menu__item <?php if( $count_compare > 0 ): ?> not-empty<?php endif; ?>">
                        <i class="fa fa-balance-scale" aria-hidden="true"></i>

                        <span id="compare-total-count" class="badge"><?= $count_compare; ?></span>
                    </a>
                    <a id="wishlist" href="<?= $wishlist ?>" title="<?= $text['header_favorite'] ?>"
                       class="header-menu__item <?php if( $count_wishlist > 0 ): ?> not-empty<?php endif; ?>">

                        <i class="fa fa-heart-o"></i>


                        <span class="badge" id="wishlist-total"><?= $count_wishlist; ?></span>
                    </a>
                    <?php echo $cart; ?>
                </div>
            </div>
        </div>
    </header>
    <?php if($menu && $isShowMenu) { ?>
    <div class="menu_wrapper">
        <script type="text/javascript" src="/catalog/view/javascript/megamenu/megamenu.js?v3"></script>
        <link rel="stylesheet" href="/catalog/view/theme/default/stylesheet/megamenu.css?v3">
        <div class="container flex-container">
            <nav id="megamenu-menu">
                <div class="navbar-header"><span id="category" class="visible-xs"><?php echo $menu_title; ?></span>
                    <button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse"
                            data-target=".navbar-ex1-collapse"><i class="fa fa-bars"></i></button>
                </div>
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                <span id="category_btn" class="buy">
                    <i class="fa fa01 fa-bars"></i>
                    Каталог товаров
                </span>
                    <ul class="nav">
                        <?php foreach ($menu as $item) { ?>
                        <?php if ($item['children']) { ?>

                        <li class="dropdown">

                            <a class="dropdown-toggle"
                               href="<?php echo $item['link']; ?>"><?if($item['image']){ ?>
                                <img class="megamenu-thumb" src="<?=$item['image']?>"/>
                                <?}?><?php echo $item['name']; ?></a>

                            <div class="dropdown-menu-custom megamenu-type-category-simple">
                                <?php foreach (array_chunk($item['children'], ceil(count($item['children']) / 1)) as $children) { ?>
                                <ul class="smart_nav">
                                    <?php foreach ($children as $child) { ?>
                                    <li class="<?if(count($child['children'])){ ?> megamenu-issubchild<?}?>"><a
                                                href="<?php echo $child['link']; ?>"><?php echo $child['name']; ?></a>

                                        <?if(count($child['children'])){ ?>
                                        <ul class="list-unstyled megamenu-ischild megamenu-ischild-simple">
                                            <?php foreach ($child['children'] as $subchild) { ?>
                                            <li>
                                                <a href="<?php echo $subchild['link ']; ?>"><?php echo $subchild['name']; ?></a>
                                            </li>
                                            <?}?>
                                        </ul>
                                        <?}?>
                                    </li>
                                    <?php } ?>
                                </ul>


                                <?php } ?>
                            </div>
                        </li>


                        <?php } else { ?>
                        <li><a href="<?php echo $item['link']; ?>"><?php echo $item['name']; ?></a></li>
                        <?php } ?>
                        <?php } ?>
                    </ul>
                </div>
            </nav>
        </div>
    </div>
    <?php } ?>
</div>