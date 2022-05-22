<div class="featured_wrap">
<h3 class="title">
  <?php echo $heading_title; ?>
</h3>
<div class="row row-products">
  <?php foreach ($products as $product) { ?>
  <div class="product-layout product-item">
    <div class="fix_position">
    <form data-id="<?php echo $product['product_id']; ?>">  
      <div class="product-thumb">
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
        <div>
          <div class="caption">
            <div class="item_head">
              <a href="<?php echo $product['href']; ?>#to_review" class="rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($product['rating'] < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-grey-o fa-star-o fa-stack-2x"></i><i class="fa fa-star-grey fa-stack-2x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php } ?>
                <?php } ?>
              </a>
              <a href="<?php echo $product['href']; ?>#to_review" class="reviews">
                <?= $text['catalog_reviews'] ?>: <?=$product['reviews']?>
              </a>
            </div>
            <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
            <?php if ($product['price']) { ?>
            <p class="price <?php if( !$product['test'] ): ?>price-lock<?php endif; ?>">
              <?php if (!$product['special']) { ?>
              <?php echo $product['price']; ?>
              <?php } else { ?>
              <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
              <?php } ?>
            </p>
                    <?php if( !$product['test'] ): ?>
                    <div class="stock-out-mess"><?= $text['product_out_of_stock'] ?><!-- Нет в наличии --></div>
                    <?php else: ?>
<div class="fake_buttons">
        <div class="fake_buttons-item_wrap">

                    <img class="fake_buttons-item" src="/catalog/view/theme/default/image/red__cart.svg" alt="">
                    <span id="product_<?= $product['product_id'] ?>_cart_2">
                    <?php if( $product['in_cart'] ): ?>
                        <img src="/catalog/view/theme/default/image/check___ic.svg" alt="" class="check-image">
                        <?php endif; ?>
                  </span>
                    
                </div>

                <!-- WISHLIST -->
                <div class="fake_buttons-item_wrap">
                  <i class="fa fa-star-o fake_buttons-item"></i>
                  <span id="product_<?= $product['product_id'] ?>_wishlist_2">
                        <?php if( $product['in_wishlist'] ): ?>
                          <img src="/catalog/view/theme/default/image/check___ic.svg" alt="" class="check-image">
                        <?php endif; ?>
                  </span>
                </div>

                <!-- COMPARE -->
                <div class="fake_buttons-item_wrap">
                  <i class="fa fa-balance-scale fake_buttons-item"></i>
                  <span id="product_<?= $product['product_id'] ?>_compare_2">
                        <?php if( $product['in_compare'] ): ?>
                          <img src="/catalog/view/theme/default/image/check___ic.svg" alt="" class="check-image">
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
                  <input type="hidden" name="product_id" value="<?php echo $product['product_id']; ?>" />
                  <button type="button" data-button-cart data-id="<?php echo $product['product_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="buy">
                      <img width="15px" src="/catalog/view/theme/default/image/white__cart.svg" alt="">
                      <?php echo $button_cart; ?></button>
                  <span id="product_<?= $product['product_id'] ?>_cart">
                  <?php if( $product['in_cart'] ): ?>
                      <img src="/catalog/view/theme/default/image/check___ic.svg" alt="" class="check-image">
                      <?php endif; ?>
                </span>
                  <?php endif; ?>
              </div>
            <div class="like_block <?php if( !$product['test'] ): ?>like_block-lock<?php endif; ?>">

              <!-- WISHLIST -->
              <div class="like_block-item">
              <button title="Добавить в избранное" type="button" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
                <i class="fa fa-star-o"></i>
              </button>
              <span id="product_<?= $product['product_id'] ?>_wishlist">
                  <?php if( $product['in_wishlist'] ): ?>
                    <img src="/catalog/view/theme/default/image/check___ic.svg" alt="" class="check-image">
                  <?php endif; ?>
                </span>
              </div>

              <!-- COMPARE -->
              <div class="like_block-item">
              <button title="К сравнению" type="button" onclick="compare.add('<?php echo $product['product_id']; ?>');">
                <i class="fa fa-balance-scale"></i>
              </button>
              <span id="product_<?= $product['product_id'] ?>_compare">
                    <?php if( $product['in_compare'] ): ?>
                      <img src="/catalog/view/theme/default/image/check___ic.svg" alt="" class="check-image">
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
        </div>
    </form>
  </div>
  <?php } ?>

</div>
</div>

<script>
  $(document).ready(function() {

// $(".product-layout").hover(function() {
//   console.log("alert!");
//   $(this).find(".item_interface").animate({
//    opacity: 1
//   },250);
// });



    $.each($(".product-layout"), function() {
       var input_price = $(this).find("input:checked + label span:nth-of-type(1)").html(); 
       var input_volume = $(this).find("input:checked + label span:nth-of-type(2)").html(); 
       var price_field = $(this).find(".price_field");
      price_field.find("span:nth-of-type(1)").html(input_price); 
      price_field.find("span:nth-of-type(2)").html(input_volume);       
    });


    $(".product-layout").ready(function() {

      var el = $(this).find(".price_field span:nth-of-type(1)").html();
      console.log(el);

      $( "input" ).change(function() {
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
    $('[data-button-cart]').on('click', function() {
        let product_id = $(this).attr( 'data-id' );

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
            beforeSend: function() {
                $('#button-cart').button('loading');
            },
            complete: function() {
                $('#button-cart').button('reset');
            },
            success: function(json) {

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
                    
                    // $('#cart > button').html('<span id="cart-total">Корзина<div class="badge">' + json['count'] + '</div></span>');
                    $('#cart-total ~ .badge').html(json['count']);

                    if(json['count'] !== 0 ) {
                        $("#cart-total").addClass("not-empty");
                    }

                    let html = '<img src="/catalog/view/theme/default/image/check___ic.svg" alt="" class="check-image">';

                    $('#product_' + product_id + '_cart').html(html);
                    $('#product_' + product_id + '_cart_2').html(html);
                    $('#product_' + product_id + '_cart_3').html(html);


                    // $('html, body').animate({ scrollTop: 0 }, 'slow');

                    var popup = $("#popup_done");
                    var popup_content = popup.find(".popup_content");


                    $(popup).css({
                        "visibility": "visible",
                        "opacity": "1"
                    });
                        
                    popup.find("p").html(json['success']);

                    popup_content.addClass("active");

                    $(".popup_close, .overlay_popup, .continue_btn").click(function() {
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
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
    //--></script>