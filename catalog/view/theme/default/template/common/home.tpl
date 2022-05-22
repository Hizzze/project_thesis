<?php echo $header; ?>

<?= $column_left ?>

    <div class="container">
        <div class="h2"><?= $text['home_header_new'] ?></div>

        <div class="row">
        <?php foreach ($new as $product): ?>
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <form data-id="<?php echo $product['product_id']; ?>" class="product-card">
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

        <br/><br/>
        <?= $content_top ?>

        <?php if($sale): ?>
        <br/><br/>


        <div class="h2"><?= $text['home_header_sale'] ?></div>

        <div class="row">
             <?php foreach ($sale as $product): ?>
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
<?php endif; ?>

<?= $content_bottom ?>
    
        </div>
    <div class="container">
        <div class="home-form">
            <div class="row">
                <div class="col-lg-3 offset-lg-7 col-md-6 offset-md-3">
                    <form class="form">
                        <div class="h2"><?= $text['bottom_form_header'] ?></div>
                        <div class="form-input">
                            <input type="text" name="name" placeholder="<?= $text['your_name'] ?>">
                        </div>
                        <div class="form-input">
                            <input type="email" name="email" placeholder="<?= $text['your_email'] ?>">
                            <button type="submit"><span class="icon-arrow-right"></span></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

<?php echo $footer; ?>