<?php echo $header; ?>
 <div class="container">
		<form class="product">
                <ul class="bread">
                    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                    <?php } ?>
                </ul>
            <input type="hidden" name="product_id" value="<?php echo $product_id; ?>"/>
            <input type="hidden" name="quantity" value="1"/>

            <div class="row">
                    <div class="col-md-7">
                        <a href="<?php echo $popup; ?>" class="product-general-image">
                            <img src="<?php echo $popup; ?>" alt="<?php echo $heading_title; ?>" />
                        </a>
                        <div class="row">
                            <?php foreach ($images as $image) { ?>
                                <div class="col-6">
                                    <a href="<?php echo $image['popup']; ?>" class="product-additional-image">
                                        <img src="<?php echo $image['popup']; ?>" alt="<?php echo $heading_title; ?>" />
                                    </a>
                                </div>
                            <?php } ?>
                        </div>
                    </div>
                    <for class="col-md-5">
                        <h1 class="product__title"><?php echo $heading_title; ?></h1>
                        <a href="<?php echo $category['href'] ?>" class="product__category"><?php echo $category['name'] ?></a>
                        <div class="product__rating">
                            <div class="stars">
                                <?php for ($i = 1; $i <= 5; $i++) { ?>
                                    <?php if ($rating < $i) { ?>
                                       <span class="icon-star"></span>
                                    <?php } else { ?>
                                        <span class="icon-star active"></span>
                                    <?php } ?>
                                <?php } ?>
                            </div>
                            <span><?php echo $reviews; ?></span>
                        </div>


                        <?php if ($price) { ?>
                            <?php if (!$special) { ?>
                                <div class="product__price">
                                    <?php echo $price; ?>
                                </div>
                            <?php } else { ?>
                                <div class="product__discount">
                                    <div class="old">
                                        <?php echo $price; ?>
                                    </div>
                                    <div class="new">
                                        <?php echo $special; ?>
                                    </div>
                                </div>
                            <?php } ?>
                        <?php } ?>

                        

                        <div class="product-options">
                            <?php foreach ($options as $option) { ?>
                                <?php if ($option['type'] == 'radio') { ?>

                                <span>
                                    <?= $option['name'] ?>
                                    <?php if($option['option_id'] == 14): ?>
                                        <a onclick="toggleModal('sizes')"><?= $text['product_sizes_table'] ?></a>
                                    <?php endif; ?>
                                </span>
                                <div class="product-options__item<?= $option['option_id'] == 15 ? ' product-options__item--colors' : '' ?><?= $option['option_id'] == 14 ? ' product-options__item--sizes' : '' ?><?= $option['required'] ? ' required' : '' ?>"  id="input-option<?php echo $option['product_option_id']; ?>">
                                    <?php $checked = true; foreach ($option['product_option_value'] as $option_value) { ?>
                                        <label>
                                        
                                            <input type="radio"
                                                    name="option[<?php echo $option['product_option_id']; ?>]"
                                                    value="<?php echo $option_value['product_option_value_id']; ?>" <?php if( $checked ): ?>
                                            checked<?php endif; $checked = false; ?> />

                                            <?php if ($option_value['image']) { ?>
                                            <img src="<?php echo $option_value['image']; ?>"
                                                    alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"/>
                                            <?php } ?>

                                            <span class="value"<?= $option['option_id'] == 15 ? ' style="background:' . $option_value['name'] . '"' : '' ?>>
                                                <?php echo $option_value['name']; ?>
                                            </span>

                                            <?php if ($option_value['price']) { ?>
                                            <span class="price_hidden" style="display: none;"><?php echo $option_value['price']; ?></span>
                                            <?php } ?>
                                        </label>
                                    <?php } ?>
                                </div>

                                <?php } ?>
    
                                <?php if ($option['type'] == 'checkbox') { ?>
                                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label"><?php echo $option['name']; ?></label>
                                    <div id="input-option<?php echo $option['product_option_id']; ?>">
                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox"
                                                        name="option[<?php echo $option['product_option_id']; ?>][]"
                                                        value="<?php echo $option_value['product_option_value_id']; ?>"/>
                                                <?php if ($option_value['image']) { ?>
                                                <img src="<?php echo $option_value['image']; ?>"
                                                        alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"
                                                        class="img-thumbnail"/>
                                                <?php } ?>
                                                <?php echo $option_value['name']; ?>
                                                <?php if ($option_value['price']) { ?>
                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>
                                                )
                                                <?php } ?>
                                            </label>
                                        </div>
                                        <?php } ?>
                                    </for>
                                </div>
                                <?php } ?>
                                
                                <?php } ?>
                                                                    
                        </form>


                        <div class="product-buy">
                            <a onclick="toggleModal('oneclick')">
                                    <?= $text['product_oneclick'] ?>
                            </a>
                            <a data-button-cart>
                                    <?= $text['product_buy'] ?>
                            </a>
                        </div>

                        <div class="product-links">
                            <a onclick="toggleModal('pay')"><?= $text['product_pay'] ?></a>
                            <a onclick="toggleModal('delivery')"><?= $text['product_delivery'] ?></a>
                            <a onclick="toggleModal('return')"><?= $text['product_return'] ?></a>
                        </div>
                    </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <?php if($description): ?>
                    <div class="product__description">
                        <div class="h2"><?php echo $heading_title; ?></div>
                        <?= $description ?>
                    </div>
                    <?php endif; ?>
                </div>
                <div class="col-md-6">
                    <div class="product-reviews">
                        <div class="h2 h2--mb20"><?= $text['product_reviews'] ?></div>
                        <!--
                        <div class="product__rating product__rating--center">
                            <div class="stars">
                                <?php for ($i = 1; $i <= 5; $i++) { ?>
                                    <?php if ($rating < $i) { ?>
                                    <span class="icon-star"></span>
                                    <?php } else { ?>
                                        <span class="icon-star active"></span>
                                    <?php } ?>
                                <?php } ?>
                            </div>
                        </div>
                        -->
                        <div id="review"></div>
                        <div class="product-reviews__button">
                            <a onclick="toggleModal('addreview')">
                            <?= $text['product_review'] ?>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <?php if($products): ?>
            <div class="h2"><?= $text['product_related'] ?></div>

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
            <?php endif; ?>
        </form>
    </div>



<div class="modal modal--pay">
    <div class="modal__bg" onclick="toggleModal('pay')"></div>
    <div class="modal__content">
        <div class="modal__close" onclick="toggleModal('pay')"></div>
        <div class="modal__header"><?= $text['product_pay'] ?></div>
        <div class="modal__text">
            <?= $text['product_pay_description'] ?>
        </div>
    </div>
</div>
    
<div class="modal modal--delivery">
    <div class="modal__bg" onclick="toggleModal('delivery')"></div>
    <div class="modal__content">
        <div class="modal__close" onclick="toggleModal('delivery')"></div>
        <div class="modal__header"><?= $text['product_delivery'] ?></div>
        <div class="modal__text">
            <?= $text['product_delivery_description'] ?>
        </div>
    </div>
</div>
    
<div class="modal modal--return">
    <div class="modal__bg" onclick="toggleModal('return')"></div>
    <div class="modal__content">
        <div class="modal__close" onclick="toggleModal('return')"></div>
        <div class="modal__header"><?= $text['product_return'] ?></div>
        <div class="modal__text">
            <?= $text['product_return_description'] ?>
        </div>
    </div>
</div>
    
<div class="modal modal--sizes">
    <div class="modal__bg" onclick="toggleModal('sizes')"></div>
    <div class="modal__content">
        <div class="modal__close" onclick="toggleModal('sizes')"></div>
        <img src="/assets/img/sizes.png" />
    </div>
</div>
    
<div class="modal modal--oneclick">
    <div class="modal__bg" onclick="toggleModal('oneclick')"></div>
    <form id="oneclick" class="modal__content modal__content--center">
        <div class="modal__close" onclick="toggleModal('oneclick')"></div>

        <div class="modal__header h2">
        <?= $text['product_oneclick'] ?>
        </div>

        <input type="hidden" name="product_id" value="<?php echo $product_id; ?>"/>
        <input type="text" placeholder="<?= $text['your_name'] ?>" name="name" />
        <div></div>
        <input type="text" placeholder="<?= $text['your_phone'] ?>" name="phone" />

        <div class="modal-buttons">
            <button type="submit" class="modal-button" id="button-oneclick">
                <?= $text['product_oneclick'] ?>
            </button>
        </div>
    </form>
</div>
    
<div class="modal modal--addreview">
    <div class="modal__bg" onclick="toggleModal('addreview')"></div>

    <?php if ($review_status) { ?>
    <form class="modal__content modal__content--center" id="form-review">
        <div class="modal__close" onclick="toggleModal('addreview')"></div>
        <?php if ($review_guest) { ?>
            <input type="text" placeholder="<?php echo $entry_name; ?>" value="<?php echo $customer_name; ?>" name="name" />

            <div class="stars-input">
                <label>
                    <input type="radio" name="rating" value="1" />
                    <span class="icon-star"></span>
                </label>
                <label>
                    <input type="radio" name="rating" value="2" />
                    <span class="icon-star"></span>
                    <span class="icon-star"></span>
                </label>
                <label>
                    <input type="radio" name="rating" value="3" />
                    <span class="icon-star"></span>
                    <span class="icon-star"></span>
                    <span class="icon-star"></span>   
                </label>
                <label>
                    <input type="radio" name="rating" value="4" />
                    <span class="icon-star"></span>
                    <span class="icon-star"></span>
                    <span class="icon-star"></span>
                    <span class="icon-star"></span>
                </label>
                <label>
                    <input type="radio" name="rating" value="5" />
                    <span class="icon-star"></span>
                    <span class="icon-star"></span>
                    <span class="icon-star"></span>
                    <span class="icon-star"></span>
                    <span class="icon-star"></span>
                </label>
            </div>

            <textarea name="text" placeholder="<?php echo $entry_review; ?>"></textarea>

            <?php echo $captcha; ?>

            <div class="modal-buttons">
                <button type="submit" class="modal-button" id="button-review">
                    <?php echo $button_continue; ?>
                </button>
            </div>
        <?php } else { ?>
            <?php echo $text_login; ?>
        <?php } ?>
    </form>
    <?php } ?>
</div>

<script>
$(document).ready(function() {
    $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

    $('#button-review').on('click', function (e) {
        e.preventDefault();
            $.ajax({
                url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
                type: 'post',
                dataType: 'json',
                data: $("#form-review").serialize(),
                beforeSend: function () {
                    $('#button-review').toggleClass('loading');
                },
                complete: function () {
                    $('#button-review').toggleClass('loading');
                },
                success: function (json) {
                    $('#form-review .modal__text').remove();

                    if (json['error']) {
                        $('#form-review .modal__close').after('<div class="modal__text modal__text--error">' +json['error'] + '</div>');
                    }
                    
                    if (json['success']) {
                        $('#form-review .modal__close').after('<div class="modal__text modal__text--success">' +json['success'] + '</div>');

                        $('input[name=\'name\']').val('');
                        $('textarea[name=\'text\']').val('');
                        $('input[name=\'rating\']:checked').prop('checked', false);
                    }
                }
            });
        });


    $('#button-oneclick').on('click', function(e) {
        e.preventDefault();
        var self$ = $(this);
        var form$ = self$.parents('form');
        
        $.ajax({
            url: 'index.php?route=checkout/cart/oneclick',
            type: 'post',
            data: form$.find('input[type=\'text\'], input[type=\'hidden\'], input[type=\'radio\']:checked, input[type=\'checkbox\']:checked, select, textarea'),
            dataType: 'json',
            beforeSend: function () {
                self$.toggleClass('loading');
            },
            complete: function () {
                self$.toggleClass('loading');
            },
            success: function (json) {
                $('.modal--oneclick .modal__text').remove();

                if (json['error']) {
                    $('.modal--oneclick .modal__header').after('<div class="modal__text modal__text--error">' +json['error'] + '</div>');
                }
                
                if (json['success']) {
                    $('.modal--oneclick .modal__header').after('<div class="modal__text modal__text--success">' +json['success'] + '</div>');
                    form$[0].reset();
                }
		
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

});
</script>
<?php echo $footer; ?>
