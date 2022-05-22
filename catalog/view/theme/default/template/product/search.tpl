<?php echo $header; ?>
    
    <div class="container">
        <div class="catalog-header">
            <div></div>
            <div class="catalog-header__title">
                <?php echo $heading_title; ?>
            </div>
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

        <?php echo $content_top; ?>

        <div class="row">
            <?php foreach ($products as $product): ?>
                <div class="col-lg-3 col-md-4 col-sm-6">
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

        <?php echo $pagination; ?>

        <?php echo $content_bottom; ?>


<?php echo $footer; ?>