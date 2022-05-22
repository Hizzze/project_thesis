<?php echo $header; ?>
<div class="container height_fix category_wrapper">
    <ul class="bread hidden-lg hidden-md">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>
    <div class="category_title clearfix"><h1 class="title"><?php echo $heading_title; ?></h1>
    </div>

    <div class="row">

        <div class="col-md-2 filter_search">
            <?php foreach ($categories as $category_1) { ?>
            <?php if( $category_1['count'] != 0 ) : ?>
            <?php if ($category_1['category_id'] == $category_id) { ?>
            <a class="active" href="<?php echo $category_1['link']; ?>"><?php echo $category_1['name']; ?> (<?php echo $category_1['count']; ?>)</a>
            <?php } else { ?>
            <a href="<?php echo $category_1['link']; ?>"><?php echo $category_1['name']; ?> (<?php echo $category_1['count']; ?>)</a>
            <?php } ?>
            <?php endif; ?>
            <?php foreach ($category_1['children'] as $category_2) { ?>
            <?php if( $category_2['count'] != 0 ) : ?>
            <?php if ($category_2['category_id'] == $category_id) { ?>
            <a class="active" href="<?php echo $category_2['link']; ?>"><?php echo $category_2['name']; ?> (<?php echo $category_2['count']; ?>)</a>
            <?php } else { ?>
            <a href="<?php echo $category_2['link']; ?>"><?php echo $category_2['name']; ?> (<?php echo $category_2['count']; ?>)</a>
            <?php } ?>
            <?php endif; ?>
            <?php foreach ($category_2['children'] as $category_3) { ?>
            <?php if( $category_3['count'] != 0 ) : ?>
            <?php if ($category_3['category_id'] == $category_id) { ?>
            <a class="active" href="<?php echo $category_3['link']; ?>"><?php echo $category_3['name']; ?> (<?php echo $category_3['count']; ?>)</a>
            <?php } else { ?>
            <a href="<?php echo $category_3['link']; ?>"><?php echo $category_3['name']; ?> (<?php echo $category_3['count']; ?>)</a>
            <?php } ?>
            <?php endif; ?>
            <?php } ?>
            <?php } ?>
            <?php } ?>
            <?php //echo $column_left; ?>
        </div>

        <?php if ($column_right) { ?>
        <?php $class = 'col-sm-12 col-md-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-10'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?>">
            <?php if($banner): ?><img src="<?= $banner ?>" style="max-width:100%"/><?php endif; ?>

            <?php if ($products) { ?>

            <div class="row">
                <div class="lines clearfix">
                    <ul class="bread">
                        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                        <?php } ?>
                    </ul>
                    <select id="input-sort" class="form-control" onchange="location = this.value;">
                        <?php foreach ($sorts as $sortss) { ?>
                        <?php if ($sortss['value'] == $sort . '-' . $order) { ?>
                        <option value="<?php echo $sortss['href']; ?>"
                                selected="selected"><?php echo $sortss['text']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $sortss['href']; ?>"><?php echo $sortss['text']; ?></option>
                        <?php } ?>
                        <?php } ?>
                    </select>
                    <div class="col-sm-4 col-md-3 quantity">
                        <div class="form-group input-group input-group-sm">
                            <label class="input-group-addon" for="input-limit"><?php echo $text_limit; ?></label>

                            <select id="input-limit" class="form-control" onchange="location = this.value;">
                                <?php foreach ($limits as $limitl) { ?>
                                <?php if ($limitl['value'] == $limit) { ?>
                                <option value="<?php echo $limitl['href']; ?>"
                                        selected="selected"><?php echo $limitl['text']; ?></option>
                                <?php } else { ?>
                                <option value="<?php echo $limitl['href']; ?>"><?php echo $limitl['text']; ?></option>
                                <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                    </div>


                </div>
            </div>

            <?php if(count($selected_options) > 0 ): ?>
            <style>
                .bread {
                    padding-top: 10px;
                }

                .options-block {
                    display: flex;
                    align-items: center;
                    flex-wrap: wrap;
                    margin-bottom: 15px;
                }

                .options-block * {
                    font-size: 14px;
                    white-space: nowrap;
                }

                .options__rest {
                    color: #00a046;
                    margin-left: 3px;
                }

                .option-block {
                    display: flex;
                    align-items: flex-start;
                    margin-right: 10px;
                }

                .option__name {
                    margin-right: 8px;
                    line-height: 30px;
                }

                .option__name:after {
                    content: ':';
                }

                .option__values {
                    display: flex;
                    align-items: center;
                    flex-wrap: wrap;
                }

                .option-block .value {
                    display: block;
                    height: 25px;
                    line-height: 25px;
                    background: #f5f5f5;
                    margin: 3px;
                    border-radius: 5px;
                    padding: 0 5px;
                }

                .option-block .value:after {
                    content: '×';
                    font-size: 16px;
                    margin-left: 5px;
                }

                @media (max-width: 768px) {
                    .option-block {
                        flex-wrap: wrap;
                    }
                }
            </style>
            <div class="options-block">
                <?php foreach($selected_options as $option): ?>
                <div class="option-block">
                    <div class="option__name"><?= $option['name'] ?></div>
                    <div class="option__values">
                        <?php foreach($option['values'] as $value): ?>
                        <a href="<?= $value['href'] ?>" class="value"><?= $value['name'] ?></a>
                        <?php endforeach; ?>
                    </div>
                </div>
                <?php endforeach; ?>
                <a href="<?= $category_href ?>" class="options__rest">Сбросить</a>
            </div>
            <?php endif; ?>
            <?php echo $content_top; ?>

            <div class="row row-products">
                <?php foreach ($products as $product) { ?>
                <div class="product-layout product-layout-category product-item">
                    <div class="fix_position">
                        <form id="product-<?php echo $product['product_id']; ?>">
                            <div class="product-thumb">
                                <?php if($product['discount']): ?>
                                <div class="discount-label black"><span>-<?= $product['discount'] ?>%</span></div>
                                <?php endif; ?>
                                <div class="image"><a href="<?php echo $product['href']; ?>"><img
                                                src="<?php echo $product['thumb']; ?>"
                                                alt="<?php echo $product['name']; ?>"
                                                title="<?php echo $product['name']; ?>" class="img-responsive"/></a>
                                </div>
                                <div>
                                    <div class="caption">
                                        <div class="item_head">
                                            <a href="<?php echo $product['href']; ?>#to_review" class="rating">
                                                <?php for ($i = 1; $i <= 5; $i++) { ?>
                                                <?php if ($product['rating'] < $i) { ?>
                                                <span class="fa fa-stack"><i
                                                            class="fa fa-star-grey-o fa-star-o fa-stack-2x"></i><i
                                                            class="fa fa-star-grey fa-stack-2x"></i></span>
                                                <?php } else { ?>
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i
                                                            class="fa fa-star-o fa-stack-2x"></i></span>
                                                <?php } ?>
                                                <?php } ?>
                                            </a>
                                            <a href="<?php echo $product['href']; ?>#to_review" class="reviews">
                                                <?= $text['catalog_reviews'] ?><!-- Отзывов -->
                                                : <?=$product['reviews']?>
                                            </a>
                                        </div>
                                        <h4>
                                            <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                        </h4>
                                        <?php if ($product['price']) { ?>
                                        <?php if (!$product['special']) { ?>
                                        <p class="price <?php if( !$product['test'] ): ?>price-lock<?php endif; ?>">
                                            <?php echo $product['price']; ?>
                                        </p>
                                        <?php } else { ?>
                                        <p class="price-line <?php if( !$product['test'] ): ?>price-lock<?php endif; ?>">
                                            <span class="price-new"><?php echo $product['special']; ?></span> <span
                                                    class="price-old"><?php echo $product['price']; ?></span>
                                            <?php } ?>
                                        </p>
                                        <?php if( !$product['test'] ): ?>
                                        <div class="stock-out-mess"><?= $text['product_out_of_stock'] ?>
                                            <!-- Нет в наличии --></div>
                                        <?php else: ?>
                                        <div class="fake_buttons">
                                            <div class="fake_buttons-item_wrap">

                                                <img class="fake_buttons-item"
                                                     src="/catalog/view/theme/default/image/red__cart.svg" alt="">
                                                <span id="product_<?= $product['product_id'] ?>_cart_2">
                    <?php if( $product['in_cart'] ): ?>
                                                    <img src="/catalog/view/theme/default/image/check___ic.svg" alt=""
                                                         class="check-image">
                                                    <?php endif; ?>
                  </span>

                                            </div>

                                            <!-- WISHLIST -->
                                            <div class="fake_buttons-item_wrap">
                                                <i class="fa fa-star-o fake_buttons-item"></i>
                                                <span id="product_<?= $product['product_id'] ?>_wishlist_2">
                        <?php if( $product['in_wishlist'] ): ?>
                                                    <img src="/catalog/view/theme/default/image/check___ic.svg" alt=""
                                                         class="check-image">
                                                    <?php endif; ?>
                  </span>
                                            </div>

                                            <!-- COMPARE -->
                                            <div class="fake_buttons-item_wrap">
                                                <i class="fa fa-balance-scale fake_buttons-item"></i>
                                                <span id="product_<?= $product['product_id'] ?>_compare_2">
                        <?php if( $product['in_compare'] ): ?>
                                                    <img src="/catalog/view/theme/default/image/check___ic.svg" alt=""
                                                         class="check-image">
                                                    <?php endif; ?>
                    </span>
                                            </div>
                                        </div>
                                        <?php endif; ?>
                                        <?php } ?>
                                        <div class="product-item__charact">
                                            <div class="item_interface">
                                                <div class="button-group">
                                                    <?php if( !$product['test'] ): ?>

                                                    <?php else: ?>
                                                    <input type="hidden" name="product_id"
                                                           value="<?php echo $product['product_id']; ?>"/>
                                                    <button type="button" data-button-cart
                                                            data-id="<?php echo $product['product_id']; ?>"
                                                            data-loading-text="<?php echo $text_loading; ?>"
                                                            class="buy">
                                                        <img width="15px"
                                                             src="/catalog/view/theme/default/image/white__cart.svg"
                                                             alt="">
                                                        <?php echo $button_cart; ?></button>
                                                    <span id="product_<?= $product['product_id'] ?>_cart">
                  <?php if( $product['in_cart'] ): ?>
                                                        <img src="/catalog/view/theme/default/image/check___ic.svg"
                                                             alt="" class="check-image">
                                                        <?php endif; ?>
                </span>
                                                    <?php endif; ?>
                                                </div>
                                                <div class="like_block <?php if( !$product['test'] ): ?>like_block-lock<?php endif; ?>">

                                                    <!-- WISHLIST -->
                                                    <div class="like_block-item">
                                                        <button title="Добавить в избранное" type="button"
                                                                onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
                                                            <i class="fa fa-star-o"></i>
                                                        </button>
                                                        <span id="product_<?= $product['product_id'] ?>_wishlist">
                  <?php if( $product['in_wishlist'] ): ?>
                                                            <img src="/catalog/view/theme/default/image/check___ic.svg"
                                                                 alt="" class="check-image">
                                                            <?php endif; ?>
                </span>
                                                    </div>

                                                    <!-- COMPARE -->
                                                    <div class="like_block-item">
                                                        <button title="К сравнению" type="button"
                                                                onclick="compare.add('<?php echo $product['product_id']; ?>');">
                                                            <i class="fa fa-balance-scale"></i>
                                                        </button>
                                                        <span id="product_<?= $product['product_id'] ?>_compare">
                    <?php if( $product['in_compare'] ): ?>
                                                            <img src="/catalog/view/theme/default/image/check___ic.svg"
                                                                 alt="" class="check-image">
                                                            <?php endif; ?>
              </span>
                                                    </div>


                                                </div>
                                            </div>
                                            <p><?php echo $product['description']; ?></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <?php } ?>
                <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
                <div class="col-sm-6 text-right"><?php echo $results; ?></div>
            </div>
            <?php } ?>
            <?php if($all_news): ?>
            <div class="news_wrapper">
                <h2 class="title">Новости</h2>
                <div class="news-row">
                    <?php foreach ($all_news as $news) { ?>
                    <div class="news_item-wrapper">
                        <a href="<?php echo $news['view']; ?>" class="news_item">
                            <div class="text-center"><img src="<?php echo $news['image']; ?>" /></div>
                            <div class="news_item-caption">
                                <div class="news_item-title">
                                    <?php echo $news['title']; ?></div>
                                <div class="news_item-descript"><?php echo $news['description']; ?></div>
                                <div class="news_item-date"><?php echo $news['date_added']; ?></div>
                            </div>
                        </a>
                    </div>
                    <?php } ?>
                </div>
                <p>
                    <a href="/news"><?=$text_show_all?></a>
                </p>
            </div>
            <?php endif; ?>
            <?php if ($description) { ?>
            <div class="seo_text">
                <?= $description ?>
            </div>
            <?php } ?>
            <?php if (!$categories && !$products) { ?>
            <p><?php echo $text_empty; ?></p>
            <div class="buttons">
                <div class="pull-right"><a href="<?php echo $continue; ?>"
                                           class="buy"><?php echo $button_continue; ?></a></div>
            </div>
            <?php } ?>
            <?php echo $content_bottom; ?></div>
        <?php echo $column_right; ?></div>
</div>
<script>
    $(document).ready(function () {


        $.each($(".product-layout"), function () {
            var input_price = $(this).find("input:checked + label span:nth-of-type(1)").html();
            var input_volume = $(this).find("input:checked + label span:nth-of-type(2)").html();
            var price_field = $(this).find(".price_field");
            price_field.find("span:nth-of-type(1)").html(input_price);
            price_field.find("span:nth-of-type(2)").html(input_volume);
        });


        $(".product-layout").ready(function () {

            var el = $(this).find(".price_field span:nth-of-type(1)").html();
            console.log(el);

            $("input").change(function () {
                var i = $(this).next().find("span:nth-of-type(1)").html();
                var b = $(this).next().find("span:nth-of-type(2)").html();
                var parent = $(this).parents(".product-layout");
                parent.find(".price_field span:nth-of-type(1)").text(i);
                parent.find(".price_field span:nth-of-type(2)").text(b).css("border-color", "#56bf9c");
                console.log(parent);
            });


        });


    });
</script>
<script type="text/javascript"><!--
    $('[data-button-cart]').on('click', function () {


        let product_id = $(this).attr('data-id');

        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: $(
                '#product-' + product_id + ' input[type=\'text\'],' +
                '#product-' + product_id + ' input[type=\'hidden\'],' +
                '#product-' + product_id + ' input[type=\'radio\']:checked,' +
                '#product-' + product_id + ' input[type=\'checkbox\']:checked,' +
                '#product-' + product_id + ' select,' +
                '#product-' + product_id + ' textarea'),
            dataType: 'json',
            beforeSend: function () {
                $('#button-cart').button('loading');
            },
            complete: function () {
                $('#button-cart').button('reset');
            },
            success: function (json) {

                if (json['redirect']) {
                    location = json['redirect'];
                }

                $('.alert, .text-danger').remove();
                $('.form-group').removeClass('has-error');

                if (json['error']) {
                    if (json['error']['option']) {
                        for (i in json['error']['option']) {
                            var element = $('#input-option' + i.replace('_', '-'));

                            if (element.parent().hasClass('input-group')) {
                                element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                            } else {
                                element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                            }
                        }
                    }

                    if (json['error']['recurring']) {
                        $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
                    }

                    // Highlight any found errors
                    $('.text-danger').parent().addClass('has-error');
                }

                if (json['success']) {
                    $('.breadcrumb').after('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

//                  $('#cart > button').html('<span id="cart-total">Корзина<div class="badge">' + json['count'] + '</div></span>');
                    $('#cart-total ~ .badge').html(json['count']);


                    let html = '<img src="/catalog/view/theme/default/image/check___ic.svg" alt="" class="check-image">';

                    $('#product_' + product_id + '_cart').html(html);
                    $('#product_' + product_id + '_cart_2').html(html);
                    $('#product_' + product_id + '_cart_3').html(html);

                    if (json['count'] !== 0) {
                        $("#cart-total").addClass("not-empty");
                    }

                    // $('html, body').animate({ scrollTop: 0 }, 'slow');

                    var popup = $("#popup_done");
                    var popup_content = popup.find(".popup_content");


                    $(popup).css({
                        "visibility": "visible",
                        "opacity": "1"
                    });

                    popup.find("p").html(json['success']);

                    popup_content.addClass("active");

                    $(".popup_close, .overlay_popup, .continue_btn").click(function () {
                        event.preventDefault();
                        $(popup).css({
                            "visibility": "hidden",
                            "opacity": "0"
                        });
                        popup_content.removeClass("active");
                    });


                    $('#cart > ul').load('index.php?route=common/cart/info ul li');
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
    //--></script>

<?php echo $footer; ?>
