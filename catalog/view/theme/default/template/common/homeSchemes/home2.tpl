<div class="container">
    <div class="row">
        <?php if($column_left || $menu): ?>
        <div class="col-md-3">
            <?php if($menu) { ?>
            <div class="menu_wrapper menu_wrapper--home">
                <script type="text/javascript" src="/catalog/view/javascript/megamenu/megamenu.js?v3"></script>
                <link rel="stylesheet" href="/catalog/view/theme/default/stylesheet/megamenu.css?v3">
                <div class="container flex-container">
                    <nav id="megamenu-menu">
                        <div class="navbar-header"><span id="category" class="visible-xs"><?php echo $menu_title; ?></span>
                            <button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse"
                                    data-target=".navbar-ex1-collapse"><i class="fa fa-bars"></i></button>
                        </div>
                        <div class="collapse navbar-collapse navbar-ex1-collapse">
                <span id="category_btn" class="buy active">
                    <i class="fa fa01 fa-bars"></i>
                    Каталог товаров
                </span>
                            <ul class="nav" style="display:block">
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
            <?= $column_left ?>
        </div>
        <?php endif; ?>
        <?php if (($column_left || $menu) && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($menu || $column_left || $column_right) { ?>
        <?php $class = 'col-sm-12 col-md-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div class="<?= $class ?>">
            <?php echo $content_top; ?>
            <div class="home_category">
                <div class="row">
                    <!-- .home_category-item.col-lg-2*18>.home_category-item-img+span{Профессиональные тренажеры} -->

                    <?php foreach($categories as $category): ?>
                    <a href="<?= $category['href'] ?>" class="home_category-item col-md-2 col-sm-3">
                        <img src="<?= $category['image'] ?>" alt=""><span><?= $category['name'] ?></span>
                    </a>
                    <?php endforeach; ?>

                </div>
            </div>
        </div>
        <?php if($column_right): ?>
        <div class="col-md-3">
            <?= $column_right ?>
        </div>
        <?php endif; ?>
    </div>
    <?php echo $content_bottom; ?>
</div>