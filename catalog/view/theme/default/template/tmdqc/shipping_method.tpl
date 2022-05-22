<div class="panel panel-default">
    <div class="panel-heading"><?php echo $text_delivery_method_title ?></div>
    <div class="panel-content">
    
    <?php if ($error_warning) { ?>
<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($shipping_methods){ ?>
<div class="row">
<?php foreach ($shipping_methods as $shipping_method) { ?>
<?php if(!$shipping_method['error']){ ?>
<?php foreach ($shipping_method['quote'] as $quote){ ?>
    <label class="col-lg-6 checkout-radio">
        <?php if($quote['code'] == $code || !$code){ ?>
        <?php $code = $quote['code']; ?>
            <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" checked="checked"/>
        <?php } else { ?>
            <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>"/>
        <?php } ?>
        <?php if($shipping_method['image']){ ?>
            <img class="checkout-radio__image" src="<?php echo $shipping_method['image']; ?>"/>
        <?php } ?>
        <?php if($tmdqc_shipping_label) { ?>
            <span class="checkout-radio__title"><?php echo $shipping_method['title']; ?></span>
        <?php } ?>

        <span class="checkout-radio__price">+<?php echo $quote['text']; ?></span>
    </label>
<?php } ?>
<?php } else { ?>
<div class="alert alert-danger"><?php echo $shipping_method['error']; ?></div>
<?php } ?>
<?php } ?>
</div>
<?php } ?>
<div class="row <?php echo $tmdqc_shipping_comment ?>">

    <script>
        jQuery(document).ready(function () {
            let shipping_method = jQuery('[name="shipping_method"]:checked').val();
            manageChangeShippingMethod(shipping_method == 'flat.flat_np');

            jQuery('[name="shipping_method"]').on('change', function (e) {
                manageChangeShippingMethod(e.target.value == 'flat.flat_np');
            });

            function manageChangeShippingMethod(np = false) {
                if (np) {
                    $('#npInputs').show();
                    $('#npArea').val($('#newpost_warehouses').val());
                    $('#commentArea textarea').val('');
                    $('#commentArea').hide();
                } else {
                    $('#npInputs').hide();
                    $('#npArea').val('');
                    $('#commentArea textarea').val('');
                    $('#commentArea').show();
                }
            }

            $('#newpost_warehouses').on('change', function (e) {
                $('#npArea').val(e.target.value);
            });
        });
    </script>
    <div class="col-sm-12" id="npInputs">
        <div class="row">
            <div class="col-lg-6">
                <div class="form-group required">
                    <label class="control-label" for="newpost_cities"><?= $text['np_city'] ?></label>
                    <input id="newpost_cities" placeholder="<?= $text['start_typing'] ?>" type="text"
                           class="form-control">
                </div>
            </div>
            <div class="col-lg-6">
                <div class="form-group required">
                    <label class="control-label" for="newpost_warehouses"><?= $text['np_warehouse'] ?></label>
                    <select id="newpost_warehouses" class="form-control">
                        <option disabled selected><?= $text['np_choose_warehouse'] ?></option>
                    </select>
                </div>
            </div>
        </div>

        <script>
            $(function () {
                $("#newpost_cities").autocomplete({
                    source: function (request, response) {
                        if (request && ((request.term && request.term.length > 1) || (request.length > 1))) {
                            var params = {
                                'apiKey': 'd1dd49719c9d6659b8123acd2f7d4a68',
                                'modelName': 'Address',
                                'calledMethod': 'searchSettlements',
                                "methodProperties": {
                                    "CityName": request.term ? request.term : request,
                                    "Limit": 20
                                }
                            };

                            $.ajax({
                                url: 'https://api.novaposhta.ua/v2.0/json/?' + $.param(params),
                                beforeSend: function (xhrObj) {
                                    xhrObj.setRequestHeader('Content-Type', 'application/json');
                                    return Number;
                                },
                                type: 'POST',
                                dataType: 'jsonp',
                                data: '{body}'
                            }).done(function (sdata) {
                                if (sdata['success'] && sdata['data'] && sdata['data'][0] && sdata['data'][0]['Addresses']) {
                                    var addresses = sdata['data'][0]['Addresses'];
                                    var newAddresses = [];
                                    for (var i = 0; i < addresses.length; i++) {
                                        newAddresses.push({
                                            id: addresses[i]['DeliveryCity'],
                                            label: addresses[i]['Present'],
                                            value: addresses[i]['DeliveryCity']
                                        });
                                    }
                                    response(newAddresses);
                                } else {
                                    response([]);
                                }
                            }).fail(function () {

                            });
                        }
                    },
                    minLength: 2,
                    select: function (event, ui) {
                        $("#newpost_cities").val(event.label);
                        var params = {
                            'apiKey': 'd1dd49719c9d6659b8123acd2f7d4a68',
                            'modelName': 'AddressGeneral',
                            'calledMethod': 'getWarehouses',
                            "methodProperties": {
                                "Language": "ru",
                                "CityRef": event.id
                            }
                        };

                        $.ajax({
                            url: 'https://api.novaposhta.ua/v2.0/json/?' + $.param(params),
                            beforeSend: function (xhrObj) {
                                xhrObj.setRequestHeader('Content-Type', 'application/json');
                                return Number;
                            },
                            type: 'POST',
                            dataType: 'jsonp',
                            data: '{body}'
                        }).done(function (data) {
                            if (data['success'] && data['data']) {
                                $('#newpost_warehouses').html('');
                                $.each(data['data'], function (i, item) {
                                    $('#newpost_warehouses').append($('<option>', {
                                        value: event.label + ' ' + item.DescriptionRu,
                                        text: item.DescriptionRu
                                    }));
                                });
                                $('#npArea').val($('#newpost_warehouses').val());
                            }
                        }).fail(function () {

                        });
                    }
                });
            });
        </script>
    </div>
    <div class="col-sm-12" id="commentArea">
        <label class="control-label"><?php echo $text_comments; ?></label>
        <textarea name="comment" id="npArea" rows="8" class="form-control"><?php echo $comment; ?></textarea>
    </div>
</div>


    </div>
</div>
