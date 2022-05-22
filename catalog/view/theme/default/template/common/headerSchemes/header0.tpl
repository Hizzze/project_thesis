<div class="header-wrapper">
    <div class="header">
        <div class="container">
            <div class="header__i">
                <ul class="nav">
                    <li>
                        <a href="/"><img src="<?= $logo ?>"/></a>
                    </li>
                    <?php if($menu && $isShowMenu): ?>
                        <?php foreach ($menu as $item) { ?>
                            <?php if ($item['children']) { ?>
                                <li class="dropdown">

                                <?php if($item['link']): ?>
                                <a class="dropdown-toggle" href="<?php echo $item['href']; ?>" <?php if($item['target'] == '_blank') { echo ' target="_blank" ';} ?> class="dropdown-toggle dropdown-img">
                                <?php if($item['image']): ?><img src="<?=$item['image']?>"/><? endif; ?>
                                <?php echo $item['name']; ?>
                                </a>
                                <?php else: ?>
                                <span><?php echo $item['name']; ?></span>
                                <?php endif; ?>


                                <div class="dropdown-menu-custom megamenu-type-category-simple">
                                    <?php foreach (array_chunk($item['children'], ceil(count($item['children']) / 1)) as $children) { ?>
                                    <div class="header-flex">
                                        <?php foreach ($children as $child) { ?>
                                        <?php if($child['link']): ?>
                                        <a href="<?php echo $child['link']; ?>" class="header-flex__item<?if(count($child['children'])){ ?> megamenu-issubchild<?}?>">
                                            <?php if($child['image']): ?><img src="<?= $child['image'] ?>"><?php endif; ?>
                                            <span><?php echo $child['name']; ?></span>
                                        </a>
                                        <?php else: ?>
                                        <span class="header-flex__item<?if(count($child['children'])){ ?> megamenu-issubchild<?}?>">
                                        <?php if($child['image']): ?><img src="<?= $child['image'] ?>"><?php endif; ?>
                                            <span><?php echo $child['name']; ?></span>
                                    </span>
                                        <?php endif; ?>
                                        <?}?>
                                    </div>
                                    <?php } ?>
                                </div>
                            </li>
                            <?php } else { ?>
                                <li><a href="<?php echo $item['link']; ?>"><?php echo $item['name']; ?></a></li>
                            <?php } ?>
                        <?php } ?>
                    <?php endif; ?>

                    <li><?php echo $search; ?></li>
                    <li><?php echo $cart; ?></li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" href=""><i class="fa fa-bars"></i></a>
                        <div class="dropdown-menu megamenu-type-html megamenu-type-html2">
                            <ul>
                                <li>
                                    <?php if ($logged) { ?>
                                    <a href="<?php echo $account; ?>"><i class="fa fa-user-o"></i><?= $customer ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $login; ?>"><i class="fa fa-user-o"></i><?php echo $text_account; ?></a>
                                    <?php } ?>
                                </li>
                                <li>
                                    <a href="<?= $compare ?>">
                                        <i class="fa fa-balance-scale" aria-hidden="true"></i><?= $text['header_compare'] ?> (<?= $count_compare; ?>)
                                    </a>

                                </li>
                                <li>
                                    <a href="<?= $wishlist ?>">
                                        <i class="fa fa-star-o" aria-hidden="true"></i><?= $text['header_favorite'] ?> (<?= $count_wishlist; ?>)
                                    </a>
                                </li>
                                <?= $menu_desktop ?>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>