<div class="mobile-menu mobile-menu--general">
    <div class="mobile-menu__close" onclick="toggleMenu('general')"></div>

    <?php foreach ($menu as $item): ?>
        <a href="<?php echo $item['link']; ?>"<?php if($item['target'] == '_blank') { echo ' target="_blank" '; } ?>>
            <?php echo $item['name']; ?>
        </a>
    <?php endforeach; ?>
</div>

<div class="modal modal--addtocart">
    <div class="modal__bg" onclick="toggleModal('addtocart')"></div>
    <div class="modal__content">
        <div class="modal__close" onclick="toggleModal('addtocart')"></div>
        <div class="modal__header"><?= $text['addtocart_header'] ?></div>
        <div class="modal__text">
            
        </div>
        <div class="modal-buttons">
            <a class="modal-button modal-button--outline" onclick="toggleModal('addtocart')"><?= $text['addtocart_continue'] ?></a>
            <a href="/checkout" class="modal-button"><?= $text['addtocart_checkout'] ?></a>
        </div>
    </div>
</div>
<div class="modal modal--callback">
    <div class="modal__bg" onclick="toggleModal('callback')"></div>
    <form id="callback" class="modal__content modal__content--center">
        <div class="modal__close" onclick="toggleModal('callback')"></div>

        <div class="modal__header h2">
        <?= $text['callback_header'] ?>
        </div>
        
        <input type="text" placeholder="<?= $text['your_name'] ?>" name="name" />
        <div></div>
        <input type="text" placeholder="<?= $text['your_phone'] ?>" name="phone" />

        <div class="modal-buttons">
            <button type="submit" class="modal-button" id="button-callback">
                <?= $text['callback_button'] ?>
            </button>
        </div>
    </form>
</div>



<?= $db_footer ?>


    <script>
        function addToCart(_t, product_id, options, quantity) {
            $.ajax({
                url: 'index.php?route=checkout/cart/add',
                type: 'post',
                data: {
                    product_id: product_id,
                    quantity: (typeof(quantity) != 'undefined' ? quantity : 1),
                    option: options
                },
                dataType: 'json',
                beforeSend: function () {
                    $(_t).toggleClass('loading');
                },
                complete: function () {
                    $(_t).toggleClass('loading');
                },
                success: function (json) {
                    if (json['redirect']) {
                        location = json['redirect'];
                    }

                    if (json['success']) {
                        $('.modal--addtocart .modal__text').html(json['success']);
                        toggleModal('addtocart');
                        
                        // let html = '<img src="/catalog/view/theme/default/image/check___ic.svg" alt="" class="check-image">';

                        // $('#product_' + product_id + '_cart').html(html);
                        // $('#product_' + product_id + '_cart_2').html(html);
                        // $('#product_' + product_id + '_cart_3').html(html);

                        // Need to set timeout otherwise it wont update the total
                        setTimeout(function () {
                            $('#cart-total ~ .badge').html(json['count']);

                            if (json['count'] !== 0) {
                                $("#cart-total").addClass("not-empty");
                            }
                        }, 100);

                        $('#cart > ul').load('index.php?route=common/cart/info ul li');
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        }

        function changeLang(lang) {
            $('#form-language [name="code"]').val(lang);
            $('#form-language').submit();
        }

        function toggleMenu(name) {
            $('.mobile-menu--' + name).toggleClass('mobile-menu--open');
        }

        function toggleModal(modal) {
            $(".modal--" + modal).toggleClass('modal--open');
        }

        function toggleTopSearch() {
            $('.header-search').toggleClass('header-search--open');
        }

        $(document).ready(function() {
            $('.sidebar-categories a.with-child').on('click', function(e) {
                var open = $(this).hasClass('open');
                $('.sidebar-categories a.with-child').removeClass('open').removeClass('active');
                if (!open) {
                    $(this).addClass('open');
                }
                
                e.preventDefault();
            });

            $('.owl-carousel').owlCarousel({
                items: 1
            });
            $(".header-search__content").mouseleave(toggleTopSearch);

            $('#button-callback').on('click', function(e) {
                e.preventDefault();
                var self$ = $(this);
                var form$ = self$.parents('form');
                
                $.ajax({
                    url: 'index.php?route=checkout/cart/callback',
                    type: 'post',
                    data: form$.find('input[type=\'text\'], input[type=\'email\'], input[type=\'hidden\'], input[type=\'radio\']:checked, input[type=\'checkbox\']:checked, select, textarea'),
                    dataType: 'json',
                    beforeSend: function () {
                        self$.toggleClass('loading');
                    },
                    complete: function () {
                        self$.toggleClass('loading');
                    },
                    success: function (json) {
                        $('.modal--callback .modal__text').remove();

                        if (json['error']) {
                            $('.modal--callback .modal__header').after('<div class="modal__text modal__text--error">' +json['error'] + '</div>');
                        }

                        if (json['success']) {
                            $('.modal--callback .modal__header').after('<div class="modal__text modal__text--success">' +json['success'] + '</div>');
                            form$[0].reset();
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            });

            $('.home-form form button').on('click', function(e) {
                e.preventDefault();
                var self$ = $(this);
                var form$ = self$.parents('form');
                
                $.ajax({
                    url: 'index.php?route=checkout/cart/newsletter',
                    type: 'post',
                    data: form$.find('input[type=\'text\'], input[type=\'email\'], input[type=\'hidden\'], input[type=\'radio\']:checked, input[type=\'checkbox\']:checked, select, textarea'),
                    dataType: 'json',
                    beforeSend: function () {
                        self$.toggleClass('loading');
                    },
                    complete: function () {
                        self$.toggleClass('loading');
                    },
                    success: function (json) {
                        form$.find('.home-form__text').remove();

                        if (json['error']) {
                            $('.home-form form .h2').after('<div class="home-form__text home-form__text--error">' +json['error'] + '</div>');
                        }

                        if (json['success']) {
                            $('.home-form form .h2').after('<div class="home-form__text home-form__text--success">' +json['success'] + '</div>');
                            form$[0].reset();
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            });

            $('[data-button-cart]').on('click', function(e) {
                e.preventDefault();
                var self$ = $(this);
                var form$ = self$.parents('form.product');
                $.ajax({
                    url: 'index.php?route=checkout/cart/add',
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
                        }

                        if (json['success']) {
                            $('.modal--addtocart .modal__text').html(json['success']);
                            toggleModal('addtocart');

                            $('#cart-total ~ .badge').html(json['count']);

                            if (json['count'] !== 0) {
                                $("#cart-total").addClass("not-empty");
                            }

                            // let html = '<img src="/catalog/view/theme/default/image/check___ic.svg" alt="" class="check-image">';

                            // $('#product_<?= $product_id ?>_cart').html(html);
                            // $('#product_<?= $product_id ?>_cart_2').html(html);
                            // $('#product_<?= $product_id ?>_cart_3').html(html);

                            $('#cart > ul').load('index.php?route=common/cart/info ul li');
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            });
        });
    </script>
    <!-- Author: stepanenko3 | Telegram: t.me/stepanenko3 | Github: github.com/stepanenko3 -->
</body>
</html>