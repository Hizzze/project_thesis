//  $(document).ready(function(){
//   $(".product-carousel").owlCarousel({
//     items:1,
//     loop:true,
//     center:true,
//     dots:true
//   });
// });

function getURLVar(key) {
    var value = [];

    var query = String(document.location).split('?');

    if (query[1]) {
        var part = query[1].split('&');

        for (i = 0; i < part.length; i++) {
            var data = part[i].split('=');

            if (data[0] && data[1]) {
                value[data[0]] = data[1];
            }
        }

        if (value[key]) {
            return value[key];
        } else {
            return '';
        }
    }
}


$(document).ready(function () {
    var userLinkCount = $(".user-links-counter");

    $("#ocfilter-content").on("click", "label", function (e) {
        e.preventDefault();
        $(this).addClass("active");
        let thisHref$ = $(this).find('a').attr('href');
        setTimeout(function () {
            window.location.replace(thisHref$);
        }, 100);
    });

    for (i = 0; i < userLinkCount.length; i++) {
        if (parseInt(userLinkCount[i].innerHTML) == 0) {
            $(userLinkCount[i]).css("visibility", "hidden");
        } else {
            $(userLinkCount[i]).css({
                "background-color": "red",
                "visibility": "visible"
            });
        }
    }

    var compareObj = {
        activated: 2
    }
    $(".compare-control__item:nth-of-type(1), .compare-control__item:nth-of-type(2)").addClass("active");
    $(".compare-control__item").each(function (index, el) {
        $(el).attr('data-comparenum', 0 + index);
        $(el).click(function () {
            if (!$(this).hasClass("active")) {
                if (compareObj.activated < 2) {
                    $(this).addClass("active");
                    compareItemShow(parseInt($(this).attr("data-comparenum")));
                } else {
                    if ($("html").attr("lang") == "ru") {
                        notify("Не больше " + compareObj.activated + " объектов");
                    } else {
                        notify("No more than " + compareObj.activated + " objects");
                    }
                }

            } else {
                $(this).removeClass("active");
                compareItemClose(parseInt($(this).attr("data-comparenum")));
            }

        });
    });

    function compareItemShow(num) {
        var i = 2 + num;
        $(".compare-page tr td:nth-of-type(" + i + ")").css({
            "display": "block"
        });

        compareObj.activated += 1;


    }

    function compareItemClose(num) {
        var i = 2 + num;
        $(".compare-page tr td:nth-of-type(" + i + ")").css({
            "display": "none"
        });

        compareObj.activated -= 1;
    }


    if ($("body").hasClass("common-home") == true) {
        function checkWidth() {
            var windowSize = $(window).width();

            if ($(window).width() < 1199 &&
                $(window).width() > 991) {
                $("#category_btn").click(function () {
                    $(this).toggleClass("active");
                });
            } else {
                $("#category_btn").off("click");

            }

        }


        // Execute on load
        checkWidth();
        // Bind event listener
        $(window).resize(checkWidth);
    }

    if ($(window).width() < 992) {
        var cart__ = $("#cart");

        $(".mob_head").append(cart__);
    } else {

        console.log("ne");
    }


    var menuxa = $("#megamenu-menu");
    var content = $("#content");

    if (content.hasClass("front_page") == true) {
        menuxa.addClass("menu_index");
    } else {
        $("#category_btn").click(function () {
            var nav = $(this).siblings(".nav");
            nav.slideToggle(200);
            $(this).toggleClass("active");
        });

    }


    $(".item_head").on("click", "a", function (event) {
        event.preventDefault();
    });

    var mobile_dropdown = $(".dropdown_mob > a");


    mobile_dropdown.click(function (event) {
        event.preventDefault();
        $(this).toggleClass("active");
        $(this).siblings("ul").slideToggle(200, function () {
        });

    });


    var $menu = $('.nav');

    $menu.menuAim({
        activate: activateSubmenu,
        deactivate: deactivateSubmenu,
        rowSelector: ".dropdown",
        exitMenu: test
    });

    function activateSubmenu(row) {
        var $row = $(row),
            $submenu = $row.children('.dropdown-menu-custom');

        $row.children('.dropdown').addClass('hover');
        $submenu.addClass("active");
    }

    function deactivateSubmenu(row) {
        var $row = $(row),
            $submenu = $row.children('.dropdown-menu-custom');

        $row.find('.dropdown').removeClass('hover');
        $submenu.removeClass("active");
        console.log(1);

    };

    function test() {
        deactivateSubmenu($menu);
        $('.dropdown.hover').removeClass('hover');
        $('.dropdown-menu-custom').removeClass("active");
    }


    $(".mob_head").on("click", "a", function (event) {

        console.log($(this).index());

        if ($(this).hasClass("mob-header-btn")) {
            event.preventDefault();
        }

        var beside = $(this).siblings("a.active");
        // var beside = $(this).find("a");
        var besideId = beside.attr("href");
        var besideContent = $(besideId);

        if (beside.hasClass("active")) {
            beside.removeClass("active");

            if (beside.attr("href") == "#mob_nav") {
                $(besideContent).css({
                    "-webkit-transform": "translateX(-100%)",
                    "-ms-transform": "translateX(-100%)",
                    "transform": "translateX(-100%)"
                });
            } else {
                $(besideContent).css({
                    "-webkit-transform": "translateY(-102%)",
                    "-ms-transform": "translateY(-102%)",
                    "transform": "translateY(-102%)"
                });
            }
        }

        $(this).toggleClass("active");
        var id = $(this).attr("href");

        if ($(this).hasClass("active")) {

            if ($(this).attr("href") == "#mob_nav") {
                $(id).css({
                    "-webkit-transform": "translateX(0)",
                    "-ms-transform": "translateX(0)",
                    "transform": "translateX(0)"
                });
            } else {
                $(id).css({
                    "-webkit-transform": "translateY(0)",
                    "-ms-transform": "translateY(0)",
                    "transform": "translateY(0)"
                });
            }
        } else {

            if ($(this).attr("href") == "#mob_nav") {
                $(id).css({
                    "-webkit-transform": "translateX(-100%)",
                    "-ms-transform": "translateX(-100%)",
                    "transform": "translateX(-100%)"
                });
            } else {
                $(id).css({
                    "-webkit-transform": "translateY(-102%)",
                    "-ms-transform": "translateY(-102%)",
                    "transform": "translateY(-102%)"
                });
            }
        }

        var close_btn = $(".close_btn");
        close_btn.click(function (event) {
            event.preventDefault()
            $(this).parent().css({
                "-webkit-transform": "translateX(-100%)",
                "-ms-transform": "translateX(-100%)",
                "transform": "translateX(-100%)"
            });
            $(".mob_head").find("a:nth-of-type(1)").removeClass("active");

        });

    });


    // Highlight any found errors
    $('.text-danger').each(function () {
        var element = $(this).parent().parent();

        if (element.hasClass('form-group')) {
            element.addClass('has-error');
        }
    });

    // Currency
    $('#form-currency .currency-select').on('click', function (e) {
        e.preventDefault();

        $('#form-currency input[name=\'code\']').val($(this).attr('name'));

        $('#form-currency').submit();
    });

    // Language
    $('#form-language .language-select').on('click', function (e) {
        e.preventDefault();

        $('#form-language input[name=\'code\']').val($(this).attr('name'));

        $('#form-language').submit();
    });

    /* Search */
    $('.search_btn input[name=\'search\']').parent().find('button').on('click', function () {
        var url = $('base').attr('href') + '/index.php?route=product/search';

        var value = $(this).parent().find('input[name=\'search\']').val();

        if (value) {
            url += '&search=' + encodeURIComponent(value);
        }

        location = url;
    });

    $('.search_btn input[name=\'search\']').on('keydown', function (e) {
        if (e.keyCode == 13) {
            $('header .search_btn input[name=\'search\']').parent().find('button').trigger('click');
        }
    });

    // Menu
    $('#menu .dropdown-menu').each(function () {
        var menu = $('#menu').offset();
        var dropdown = $(this).parent().offset();

        var i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());

        if (i > 0) {
            $(this).css('margin-left', '-' + (i + 10) + 'px');
        }
    });

    // Product List
    $('#list-view').click(function () {
        $('#content .product-grid > .clearfix').remove();

        $('#content .row > .product-grid').attr('class', 'product-layout product-list col-xs-12');
        $('#grid-view').removeClass('active');
        $('#list-view').addClass('active');

        localStorage.setItem('display', 'list');
    });

    // Product Grid
    $('#grid-view').click(function () {
        // What a shame bootstrap does not take into account dynamically loaded columns
        var cols = $('#column-right, #column-left').length;

        if (cols == 2) {
            $('#content .product-list').attr('class', 'product-layout product-grid col-lg-6 col-md-6 col-sm-12 col-xs-12');
        } else if (cols == 1) {
            $('#content .product-list').attr('class', 'product-layout product-grid col-lg-4 col-md-4 col-sm-6 col-xs-12');
        } else {
            $('#content .product-list').attr('class', 'product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-12');
        }

        $('#list-view').removeClass('active');
        $('#grid-view').addClass('active');

        localStorage.setItem('display', 'grid');
    });

    if (localStorage.getItem('display') == 'list') {
        $('#list-view').trigger('click');
        $('#list-view').addClass('active');
    } else {
        $('#grid-view').trigger('click');
        $('#grid-view').addClass('active');
    }

    // Checkout
    $(document).on('keydown', '#collapse-checkout-option input[name=\'email\'], #collapse-checkout-option input[name=\'password\']', function (e) {
        if (e.keyCode == 13) {
            $('#collapse-checkout-option #button-login').trigger('click');
        }
    });

    // tooltips on hover
    $('[data-toggle=\'tooltip\']').tooltip({container: 'body'});

    // Makes tooltips work on ajax generated content
    $(document).ajaxStop(function () {
        $('[data-toggle=\'tooltip\']').tooltip({container: 'body'});
    });
});

// Cart add remove functions
var cart = {
    'add': function (product_id, quantity) {
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: 'product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
            dataType: 'json',
            beforeSend: function () {
                $('#cart > button').button('loading');
            },
            complete: function () {
                $('#cart > button').button('reset');
            },
            success: function (json) {
                $('.alert, .text-danger').remove();

                if (json['redirect']) {
                    location = json['redirect'];
                }

                if (json['success']) {
                    // $('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

                    let html = '<img src="/catalog/view/theme/default/image/check___ic.svg" alt="" class="check-image">';

                    $('#product_' + product_id + '_cart').html(html);
                    $('#product_' + product_id + '_cart_2').html(html);
                    $('#product_' + product_id + '_cart_3').html(html);

                    // Need to set timeout otherwise it wont update the total
                    setTimeout(function () {
                        $('#cart-total ~ .badge').html(json['count']);
                        // 	$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');


                        if (json['count'] !== 0) {
                            $("#cart-total").addClass("not-empty");
                        }
                    }, 100);

                    // $('html, body').animate({ scrollTop: 0 }, 'slow');

                    $('#cart > ul').load('index.php?route=common/cart/info ul li');
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    },
    'update': function (key, quantity) {
        $.ajax({
            url: 'index.php?route=checkout/cart/edit',
            type: 'post',
            data: 'key=' + key + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
            dataType: 'json',
            beforeSend: function () {
                $('#cart > button').button('loading');
            },
            complete: function () {
                $('#cart > button').button('reset');
            },
            success: function (json) {
                // Need to set timeout otherwise it wont update the total
                setTimeout(function () {
                    // $('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
                    $('#cart-total ~ .badge').html(json['count']);
                }, 100);

                if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
                    location = 'index.php?route=checkout/cart';
                } else {
                    $('#cart > ul').load('index.php?route=common/cart/info ul li');
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    },
    'remove': function (key, product_id = 0) {
        $.ajax({
            url: 'index.php?route=checkout/cart/remove',
            type: 'post',
            data: 'key=' + key,
            dataType: 'json',
            beforeSend: function () {
                $('#cart > button').button('loading');
            },
            complete: function () {
                $('#cart > button').button('reset');
            },
            success: function (json) {
                // Need to set timeout otherwise it wont update the total
                setTimeout(function () {


                    $('#cart-total ~ .badge').html(json['count']);
                    // $('#cart > button').html('<span id="cart-total">Корзина<div class="badge">' + json['count'] + '</div></span>');

                    if (json['count'] !== 0) {
                        $("#cart-total").addClass("not-empty");
                    }
                    if (json['count'] === 0) {
                        $("#cart-total").removeClass("not-empty");
                    }
                }, 100);

                let html = '';

                $('#product_' + product_id + '_cart').html(html);
                $('#product_' + product_id + '_cart_2').html(html);
                $('#product_' + product_id + '_cart_3').html(html);


                if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
                    location = 'index.php?route=checkout/cart';
                } else {
                    $('#cart > ul').load('index.php?route=common/cart/info ul li');
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
}

var voucher = {
    'add': function () {

    },
    'remove': function (key) {
        $.ajax({
            url: 'index.php?route=checkout/cart/remove',
            type: 'post',
            data: 'key=' + key,
            dataType: 'json',
            beforeSend: function () {
                $('#cart > button').button('loading');
            },
            complete: function () {
                $('#cart > button').button('reset');
            },
            success: function (json) {
                // Need to set timeout otherwise it wont update the total
                setTimeout(function () {
                    $('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
                }, 100);

                if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
                    location = 'index.php?route=checkout/cart';
                } else {
                    $('#cart > ul').load('index.php?route=common/cart/info ul li');
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
}
var wishlist = {
    'add': function(product_id) {
        $.ajax({
            url: 'index.php?route=account/wishlist/add',
            type: 'post',
            data: 'product_id=' + product_id,
            dataType: 'json',
            success: function(json) {
                $('.alert').remove();

                if (json['redirect']) {
                    location = json['redirect'];
                }


                if (json['success']) {

                    let html = '<img src="/catalog/view/theme/default/image/check___ic.svg" alt="" class="check-image">';

                    $('#product_' + product_id + '_wishlist').html(html);
                    $('#product_' + product_id + '_wishlist_2').html(html);
                    $('#product_' + product_id + '_wishlist_3').html(html);
                    //
                    // if ($("#content").hasClass("front_page")) {
                    // 	$('#content > img').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                    // } else {
                    // 	$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                    // }

                }


                if(json['count'] > 0 ) {
                    $("#wishlist").addClass("not-empty");
                }

                $('#wishlist-total').html(json['count']);
                $('#wishlist-mob-counter').html(json['count']).css({"background-color": "red", "visibility": "visible"});

                //
                // $('html, body').animate({ scrollTop: 0 }, 'slow');
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    },
    'remove': function() {

    }
}

var compare = {
    'add': function (product_id) {
        if (!$("#compare-mob-counter").html() || parseInt($("#compare-mob-counter").html()) < 4) {
            $.ajax({
                url: 'index.php?route=product/compare/add',
                type: 'post',
                data: 'product_id=' + product_id,
                dataType: 'json',
                success: function (json) {
                    $('.alert').remove();

                    if (json['success']) {
                        // if ($("#content").hasClass("front_page")) {
                        // 	$('#content > img').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                        // } else {
                        // 	$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                        // }

                        let html = '<img src="/catalog/view/theme/default/image/check___ic.svg" alt="" class="check-image">';

                        $('#product_' + product_id + '_compare').html(html);
                        $('#product_' + product_id + '_compare_2').html(html);
                        $('#product_' + product_id + '_compare_3').html(html);

                        $('#compare-total-count').html(json['count']);
                        $('#compare-mob-counter').html(json['count']).css({
                            "background-color": "red",
                            "visibility": "visible"
                        });

                        if (json['count'] > 0) {
                            $("#compare").addClass("not-empty");
                        }

                        // $('html, body').animate({ scrollTop: 0 }, 'slow');
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        } else {
            if ($("html").attr("lang") == "ru") {
                notify("К сравнению можно добавить только 4 товара");
            } else {
                notify("By comparison, you can add only 4 products");
            }
        }
    },
    'remove': function () {

    }
}

var timeoutNote;

function hideNotice() {
    var notice = document.getElementById("notice");
    notice.style.visibility = "hidden";
    timeoutNote = clearTimeout(timeoutNote);
}

function notify(text) {
    var notice = document.getElementById("notice");
    notice.style.visibility = "visible";
    notice.innerHTML = text;
    timeoutNote = setTimeout("hideNotice()", 2000);
}

/* Agree to Terms */
$(document).delegate('.agree', 'click', function (e) {
    e.preventDefault();

    $('#modal-agree').remove();

    var element = this;

    $.ajax({
        url: $(element).attr('href'),
        type: 'get',
        dataType: 'html',
        success: function (data) {
            html = '<div id="modal-agree" class="modal">';
            html += '  <div class="modal-dialog">';
            html += '    <div class="modal-content">';
            html += '      <div class="modal-header">';
            html += '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
            html += '        <h4 class="modal-title">' + $(element).text() + '</h4>';
            html += '      </div>';
            html += '      <div class="modal-body">' + data + '</div>';
            html += '    </div';
            html += '  </div>';
            html += '</div>';

            $('body').append(html);

            $('#modal-agree').modal('show');
        }
    });
});

// Autocomplete */
(function ($) {
    $.fn.autocomplete = function (option) {
        return this.each(function () {
            this.timer = null;
            this.items = new Array();

            $.extend(this, option);

            $(this).attr('autocomplete', 'off');

            // Focus
            $(this).on('focus', function () {
                this.request();
            });

            // Blur
            $(this).on('blur', function () {
                setTimeout(function (object) {
                    object.hide();
                }, 200, this);
            });

            // Keydown
            $(this).on('keydown', function (event) {
                switch (event.keyCode) {
                    case 27: // escape
                        this.hide();
                        break;
                    default:
                        this.request();
                        break;
                }
            });

            // Click
            this.click = function (event) {
                event.preventDefault();

                value = $(event.target).parent().attr('data-value');

                if (value && this.items[value]) {
                    this.select(this.items[value]);
                }
            }

            // Show
            this.show = function () {
                var pos = $(this).position();

                $(this).siblings('ul.dropdown-menu').css({
                    top: pos.top + $(this).outerHeight(),
                    left: pos.left
                });

                $(this).siblings('ul.dropdown-menu').show();
            }

            // Hide
            this.hide = function () {
                $(this).siblings('ul.dropdown-menu').hide();
            }

            // Request
            this.request = function () {
                clearTimeout(this.timer);

                this.timer = setTimeout(function (object) {
                    object.source($(object).val(), $.proxy(object.response, object));
                }, 200, this);
            }

            // Response
            this.response = function (json) {
                html = '';

                if (json.length) {
                    for (i = 0; i < json.length; i++) {
                        this.items[json[i]['value']] = json[i];
                    }

                    for (i = 0; i < json.length; i++) {
                        if (!json[i]['category']) {
                            html += '<li data-value="' + json[i]['value'] + '"><a href="#">' + json[i]['label'] + '</a></li>';
                        }
                    }

                    // Get all the ones with a categories
                    var category = new Array();

                    for (i = 0; i < json.length; i++) {
                        if (json[i]['category']) {
                            if (!category[json[i]['category']]) {
                                category[json[i]['category']] = new Array();
                                category[json[i]['category']]['name'] = json[i]['category'];
                                category[json[i]['category']]['item'] = new Array();
                            }

                            category[json[i]['category']]['item'].push(json[i]);
                        }
                    }

                    for (i in category) {
                        html += '<li class="dropdown-header">' + category[i]['name'] + '</li>';

                        for (j = 0; j < category[i]['item'].length; j++) {
                            html += '<li data-value="' + category[i]['item'][j]['value'] + '"><a href="#">&nbsp;&nbsp;&nbsp;' + category[i]['item'][j]['label'] + '</a></li>';
                        }
                    }
                }

                if (html) {
                    this.show();
                } else {
                    this.hide();
                }

                $(this).siblings('ul.dropdown-menu').html(html);
            }

            $(this).after('<ul class="dropdown-menu"></ul>');
            $(this).siblings('ul.dropdown-menu').delegate('a', 'click', $.proxy(this.click, this));

        });
    }
})(window.jQuery);


(function ($) {
    var cache = [];
    $.preLoadImages = function () {
        var args_len = arguments.length;
        for (var i = args_len; i--;) {
            var cacheImage = document.createElement('img');
            cacheImage.src = arguments[i];
            cache.push(cacheImage);
        }
    }
})(jQuery)
jQuery.preLoadImages("/catalog/view/theme/default/image/magnifying-glass.svg");