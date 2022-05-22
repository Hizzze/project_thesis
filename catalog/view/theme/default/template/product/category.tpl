<?php echo $header; ?>
    
    <div class="container">

            <ul class="bread">
                    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                    <?php } ?>
                </ul>
	
        <div class="catalog-header">
            <div></div>   
                <h1 class="catalog-header__title"><?php echo $heading_title; ?></h1>
            <select id="input-sort" onchange="location = this.value;">
                <?php foreach ($sorts as $sortss) { ?>
                    <?php if ($sortss['value'] == $sort . '-' . $order) { ?>
                        <option value="<?php echo $sortss['href']; ?>" selected="selected"><?php echo $sortss['text']; ?></option>
                    <?php } else { ?>
                        <option value="<?php echo $sortss['href']; ?>"><?php echo $sortss['text']; ?></option>
                    <?php } ?>
                <?php } ?>
            </select>
        </div>

        <div class="row">
            <div class="col-lg-3 col-md-4">
                <?= $column_left ?>
            </div>
            <div class="col-lg-9 col-md-8">

                <?php if($banner): ?><!--<img src="<?= $banner ?>" style="max-width:100%"/>--><?php endif; ?>

                <?php echo $content_top; ?>

                <?php if(count($selected_options) > 0 ): ?>
                <div class="options-block">
                    <?php foreach($selected_options as $option): ?>
                    <div class="option-block">
                        <div class="option__name"><?= $option['name'] ?></div>
                        <div class="option__values">
                            <?php foreach($option['values'] as $value): ?>
                                <a href="<?= $value['href'] ?>"<?= $option['id'] == 30133 ? ' style="background:' . $value['name'] . '"' : '' ?> class="value<?php $option['id'] == 30134 ? ' value--size' : '' ?><?= $option['id'] == 30133 ? ' value--color' : '' ?>">
                                    <?= $value['name'] ?>
                                    <span class="icon-close"></span>
                                </a>
                            <?php endforeach; ?>
                        </div>
                    </div>
                    <?php endforeach; ?>
                    <a href="<?= $category_href ?>" class="options-block__rest"><?= $text['filters_reset'] ?></a>
                </div>
                <?php endif; ?>

                <div class="row">
                    <?php foreach ($products as $product): ?>
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <form id="product-<?php echo $product['product_id']; ?>" class="product-card">
                                <a href="<?php echo $product['href']; ?>">
                                    <img class="product-card__img" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />
                                </a>
                                <a href="<?php echo $product['href']; ?>" class="product-card__title">
                                   <?php echo $product['name']; ?>
                                </a>
                                <a href="<?= $product['category']['href'] ?>" class="product-card__category">
                                    <?= $product['category']['name']; ?>
                                </a>
                                <div class="product-card__options">
                                    <?php foreach($product['options'] as $option): ?>
                                        <?php if($option['option_id'] == 14): ?>
                                            <?php foreach($option['product_option_value'] as $value): ?>
                                                <a onclick="addToCart(this, <?= $product['product_id'] ?>, {<?= $option['product_option_id'] ?>: <?= $value['product_option_value_id'] ?>})">
                                                    <?= $value['name'] ?>
                                                </a>
                                            <?php endforeach; ?>
                                        <?php endif; ?>
                                    <?php endforeach; ?>
                                </div>
                                
                                <?php if ($product['price']): ?>
                                    <?php if (!$product['special']): ?>
                                        <div class="product-card__price">
                                            <?= $product['price']; ?>
                                        </div>
                                    <?php else: ?>
                                    <div class="product-card__discount">
                                        <div class="old"><?php echo $product['price']; ?></div>
                                        <div class="new"><?php echo $product['special']; ?></div>
                                    </div>
                                    <?php endif; ?>
                                <?php endif; ?>
                            </form>
                        </div>
                        <?php endforeach; ?>
                    </div>
                </div>
            </div>
        </div>

        <?php echo $pagination; ?>

        <?php echo $content_bottom; ?>

        <div class="container">

            <?php if ($description): ?>
                <div class="seo_text">
                    <?= $description ?>
                </div>
            <?php endif; ?>
        </div>


<?php echo $footer; ?>