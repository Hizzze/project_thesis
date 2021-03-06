<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right"><a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
        <button type="submit" form="form-product" formaction="<?php echo $copy; ?>" data-toggle="tooltip" title="<?php echo $button_copy; ?>" class="btn btn-default"><i class="fa fa-copy"></i></button>
        <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-product').submit() : false;"><i class="fa fa-trash-o"></i></button>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
        <div class="well">
          <div class="row">
            <div class="col-sm-3">
              <div class="form-group">
                <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              </div>
            </div>
            <div class="col-sm-3">
              <?php if (!$ocstore || $ocstore && VERSION < '2.3.0.2') { ?>

              <?php if ($ocstore && VERSION == '2.3.0.2') { ?>
              <div class="form-group">
                <label class="control-label" for="input-model"><?php echo $entry_model; ?></label>
                <input type="text" name="filter_model" value="<?php echo $filter_model; ?>" placeholder="<?php echo $entry_model; ?>" id="input-model" class="form-control" />
              </div>
              <?php } ?>
              <?php if (!$ocstore || $ocstore && VERSION < '2.3.0.2') { ?>
              <div class="form-group">
                <label class="control-label" for="input-sku"><?php echo $entry_sku; ?></label>
                <input type="text" name="filter_sku" value="<?php echo $filter_sku; ?>" placeholder="<?php echo $entry_sku; ?>" id="input-sku" class="form-control" />
              </div>
              <?php } ?>
              <?php } ?>
              <?php if ($ocstore && VERSION >= '2.3.0.2') { ?>
              <div class="form-group">
                <label class="control-label" for="input-sku"><?php echo $entry_sku; ?></label>
                <input type="text" name="filter_sku" value="<?php echo $filter_sku; ?>" placeholder="<?php echo $entry_sku; ?>" id="input-sku" class="form-control" />
              </div>
              <?php } ?>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label class="control-label" for="input-manufacturer"><?php echo $entry_manufacturer; ?></label>
                <select name="filter_manufacturer" id="input-manufacturer" class="form-control" />
                <option value="*"></option>
                <?php foreach ($manufacturers as $manufacturer) { ?>
                <?php if ($manufacturer['manufacturer_id']==$filter_manufacturer) { ?>
                <option value="<?php echo $manufacturer['manufacturer_id']; ?>" selected="selected"><?php echo $manufacturer['name']; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
                <?php } else { ?>
                <option value="<?php echo $manufacturer['manufacturer_id']; ?>">&nbsp;&nbsp;<?php echo $manufacturer['name']; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
                <?php } ?>
                <?php } ?>
                </select>
              </div>
            </div>
            <div class="col-sm-3">
              <?php if (!$ocstore || $ocstore && VERSION == '2.1.0.1') { ?>
              <div class="form-group">
                <label class="control-label" for="input-category"><?php echo $entry_category_filter; ?></label>
                <select name="filter_category" id="input-category" class="form-control" />
                <option value="*"></option>
                <?php foreach ($categories as $category) { ?>
                <?php if ($category['category_id']==$filter_category) { ?>
                <option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
                <?php } else { ?>
                <option value="<?php echo $category['category_id']; ?>">&nbsp;&nbsp;<?php echo $category['name']; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
                <?php } ?>
                <?php } ?>
                </select>
              </div>
              <?php } ?>
            </div>

            <div class="col-sm-3 col-sm-offset-9" style="display: none">
              <button type="button" id="button-filter" style="margin-top: 35px" class="btn btn-primary pull-right"><i class="fa fa-filter"></i> <?php echo $button_filter; ?></button>
            </div>


              <!--
                <?php if ($ocstore && VERSION == '2.3.0.2') { ?>
                <div class="form-group">
                    <label class="control-label" for="input-model"><?php echo $entry_model; ?></label>
                    <input type="text" name="filter_model" value="<?php echo $filter_model; ?>" placeholder="<?php echo $entry_model; ?>" id="input-model" class="form-control" />
                </div>
                <?php } ?>
                -->
            <!--
            <div class="form-group">
              <label class="control-label" for="input-model"><?php echo $entry_model; ?></label>
              <input type="text" name="filter_model" value="<?php echo $filter_model; ?>" placeholder="<?php echo $entry_model; ?>" id="input-model" class="form-control" />
            </div>
          </div>
          <div class="col-sm-4">
            <div class="form-group">
              <label class="control-label" for="input-price"><?php echo $entry_price; ?></label>
              <input type="text" name="filter_price" value="<?php echo $filter_price; ?>" placeholder="<?php echo $entry_price; ?>" id="input-price" class="form-control" />
            </div>

              <?php if ($ocstore && VERSION >= '2.3.0.2') { ?>
              <div class="form-group">
                  <label class="control-label" for="input-sku"><?php echo $entry_sku; ?></label>
                  <input type="text" name="filter_sku" value="<?php echo $filter_sku; ?>" placeholder="<?php echo $entry_sku; ?>" id="input-sku" class="form-control" />
              </div>
              <?php } ?>

          -->


            <!--
            <div class="form-group">
              <label class="control-label" for="input-quantity"><?php echo $entry_quantity; ?></label>
              <input type="text" name="filter_quantity" value="<?php echo $filter_quantity; ?>" placeholder="<?php echo $entry_quantity; ?>" id="input-quantity" class="form-control" />
            </div>

              <?php if (!$ocstore || $ocstore && VERSION == '2.1.0.1') { ?>
              <div class="form-group">
                  <label class="control-label" for="input-category"><?php echo $entry_category_filter; ?></label>
                  <select name="filter_category" id="input-category" class="form-control" />
                      <option value="*"></option>
                      <?php foreach ($categories as $category) { ?>
                          <?php if ($category['category_id']==$filter_category) { ?>
                              <option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
                          <?php } else { ?>
                              <option value="<?php echo $category['category_id']; ?>">&nbsp;&nbsp;<?php echo $category['name']; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
                          <?php } ?>
                      <?php } ?>
                  </select>
              </div>
              <?php } ?>

-->

            <!--
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-status"><?php echo $entry_status; ?></label>
                <select name="filter_status" id="input-status" class="form-control">
                  <option value="*"></option>
                  <?php if ($filter_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if (!$filter_status && !is_null($filter_status)) { ?>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
              <div class="form-group">
                <label class="control-label" for="input-image"><?php echo $entry_image; ?></label>
                <select name="filter_image" id="input-image" class="form-control">
                  <option value="*"></option>
                  <?php if ($filter_image) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if (!$filter_image && !is_null($filter_image)) { ?>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
-->

            <!-- </div> -->
          </div>
        </div>
        <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-product">
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
              <tr>
                <td>ID</td>
                <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                <td class="text-center"><?php echo $column_image; ?></td>
                <td class="text-left"><?php if ($sort == 'pd.name') { ?>
                  <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                  <?php } ?></td>
                <td>??????????????</td>
                <!--
                <td class="text-left"><?php if ($sort == 'p.model') { ?>
                  <a href="<?php echo $sort_model; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_model; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_model; ?>"><?php echo $column_model; ?></a>
                  <?php } ?></td>
                  -->
                <td class="text-right" width="175">????????</td>

                <td class="text-right"><?php if ($sort == 'p.price') { ?>
                  <a href="<?php echo $sort_price; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_price; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_price; ?>"><?php echo $column_price; ?></a>
                  <?php } ?></td>

                <?php if (!$ocstore || VERSION == '2.1.0.1' ) { ?>
                <td class="text-left">
                  <?php echo $entry_category; ?>
                </td>
                <?php } ?>
                <!--
                      <td class="text-right"><?php if ($sort == 'p.quantity') { ?>
                        <a href="<?php echo $sort_quantity; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_quantity; ?></a>
                        <?php } else { ?>
                        <a href="<?php echo $sort_quantity; ?>"><?php echo $column_quantity; ?></a>
                        <?php } ?></td>
                        -->
                <td class="text-left"><?php if ($sort == 'p.status') { ?>
                  <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                  <?php } ?></td>
                <td width="100">????????.</td>
                <td class="text-right"><?php echo $column_action; ?></td>
              </tr>
              </thead>
              <tbody>
              <?php if ($products) { ?>
              <?php foreach ($products as $product) { ?>
              <tr>
                <td><?= $product['product_id'] ?><input type="hidden" name="product_id" value="<?= $product['product_id'] ?>"></td>
                <td class="text-center"><?php if (in_array($product['product_id'], $selected)) { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" checked="checked" />
                  <?php } else { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" />
                  <?php } ?></td>
                <td class="text-center"><?php if ($product['image']) { ?>
                  <img src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>" class="img-thumbnail" />
                  <?php } else { ?>
                  <span class="img-thumbnail list"><i class="fa fa-camera fa-2x"></i></span>
                  <?php } ?></td>
                <td class="text-left"><?php echo $product['name']; ?></td>
                <td class="text-left"><?php echo $product['sku']; ?></td>
                <td class="text-right">
                  <?php if ($product['special']) { ?>
                  <span style="text-decoration: line-through;"><?php echo $product['price']; ?> <?= $currentCurrency['code'] ?></span><br/>
                  <div class="text-danger"><?php echo $product['special']; ?> <?= $currentCurrency['code'] ?></div>
                  <?php } else { ?>
                  <input type="hidden" name="price" value="<?php echo $product['price']; ?>" class="form-control" />
                  <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                    <input type="text" placeholder="????????" data-rate="<?= $product['currency']['value'] ?>" class="form-control" onchange="calculate(event)" value="<?php echo round($product['price'] / $product['currency']['value'] * $currentCurrency['value'], 3); ?>">
                    <div class="input-group-addon"><?= $product['currency']['code'] ?></div>
                  </div>

                  <?php } ?></td>
                <td class="default-currency-price">
                  <span><?php echo $product['price']; ?></span> <?= $currentCurrency['code'] ?>
                </td>

                <?php if (!$ocstore || $ocstore && VERSION == '2.1.0.1') { ?>
                <td class="text-left">
                  <?php foreach ($categories as $category) { ?>
                  <?php if (in_array($category['category_id'], $product['category'])) { ?>
                  <?php echo $category['name'];?><br>
                  <?php } ?>
                  <?php } ?>
                </td>
                <?php } ?>
                <!--
                          <td class="text-right"><?php if ($product['quantity'] <= 0) { ?>
                            <span class="label label-warning"><?php echo $product['quantity']; ?></span>
                            <?php } elseif ($product['quantity'] <= 5) { ?>
                            <span class="label label-danger"><?php echo $product['quantity']; ?></span>
                            <?php } else { ?>
                            <span class="label label-success"><?php echo $product['quantity']; ?></span>
                            <?php } ?></td>
                          -->
                <td class="text-left">
                  <select name="status" class="form-control" onchange="clickButton(event)">
                    <option value="0" <?php if($product['status'] == '??????????????????'): ?>selected<?php endif; ?>>??????????????????</option>
                    <option value="1" <?php if($product['status'] == '????????????????'): ?>selected<?php endif; ?>>????????????????</option>
                  </select>
                </td>
                <td class="text-left"><input onchange="clickButton(event)" type="number" name="sort_order" class="form-control" value="<?php echo $product['sort_order']; ?>"></td>
                <td class="text-right">
                  <a href="<?php echo $product['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
                </td>
              </tr>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--

      function calculate(e) {
          var input$ = $(e.target);
          var row$ = input$.parents('tr');
          var price$ = row$.find('[name="price"]');
          var def$ = row$.find('.default-currency-price span');
          var curValue = input$.attr('data-rate');

          var defValue = <?= $currentCurrency['value'] ?>;

          def$.html(+input$.val() / defValue * curValue);
          price$.val(+input$.val() / defValue * curValue);

          clickButton(e);
      }

      function clickButton(e) {
          e.preventDefault();

          var button$ = $(e.target);
          var row$ = button$.parents('tr');
          var price = row$.find('[name="price"]').val();
          var status = row$.find('[name="status"]').val();
          var sort_order = row$.find('[name="sort_order"]').val();
          var product_id = row$.find('[name="product_id"]').val();

          var data = {
              product_id: product_id,
              status: status,
              sort_order: sort_order,
          };

          if(price) {
              data.price = price;
          }

          $.ajax({
              url: 'index.php?route=catalog/product/save&token=<?php echo $token; ?>',
              data: data,
              method: 'post',
              dataType: 'json',
              success: function(json) {
                  toastr.success('?????????? ?????????????? ????????????????')
              }
          });
      }

      $('input[name=\'filter_name\'], input[name=\'filter_sku\'], select[name="filter_manufacturer"], select[name="filter_category"]').on('change', function(){$('#button-filter').click()});

      $('#button-filter').on('click', function() {
          var url = 'index.php?route=catalog/product&token=<?php echo $token; ?>';

          var filter_name = $('input[name=\'filter_name\']').val();

          if (filter_name) {
              url += '&filter_name=' + encodeURIComponent(filter_name);
          }


      <?php if (empty($ocstore)) $ocstore = '0'; ?>
          var ocstore = <?=$ocstore?>;
          var version = '<?=VERSION?>';
          if (ocstore == 0 || ocstore != 0 && version == '2.1.0.1') {
              var filter_category = $('select[name=\'filter_category\']').val();
              if (filter_category != '*') {
                  url += '&filter_category=' + encodeURIComponent(filter_category);
              }
          }

          var filter_manufacturer = $('select[name=\'filter_manufacturer\']').val();
          if (filter_manufacturer != '*') {
              url += '&filter_manufacturer=' + encodeURIComponent(filter_manufacturer);
          }

          var filter_sku = $('input[name=\'filter_sku\']').val();
          if (filter_sku) {
              url += '&filter_sku=' + encodeURIComponent(filter_sku);
          }

//	var filter_model = $('input[name=\'filter_model\']').val();
//
//	if (filter_model) {
//		url += '&filter_model=' + encodeURIComponent(filter_model);
//	}
//
//	var filter_price = $('input[name=\'filter_price\']').val();
//
//	if (filter_price) {
//		url += '&filter_price=' + encodeURIComponent(filter_price);
//	}
//
//	var filter_quantity = $('input[name=\'filter_quantity\']').val();
//
//	if (filter_quantity) {
//		url += '&filter_quantity=' + encodeURIComponent(filter_quantity);
//	}
//
//	var filter_status = $('select[name=\'filter_status\']').val();
//
//	if (filter_status != '*') {
//		url += '&filter_status=' + encodeURIComponent(filter_status);
//	}
//
//  var filter_image = $('select[name=\'filter_image\']').val();
//
//  if (filter_image != '*') {
//    url += '&filter_image=' + encodeURIComponent(filter_image);
//  }

          location = url;
      });
      //--></script>
  <script type="text/javascript"><!--
      $('input[name=\'filter_name\']').autocomplete({
          'source': function(request, response) {
              $.ajax({
                  url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                  dataType: 'json',
                  success: function(json) {
                      response($.map(json, function(item) {
                          return {
                              label: item['name'],
                              value: item['product_id']
                          }
                      }));
                  }
              });
          },
          'select': function(item) {
              $('input[name=\'filter_name\']').val(item['label']);
              $('input[name=\'filter_name\']').change();
          }
      });


      $('input[name=\'filter_sku\']').autocomplete({
          'source': function(request, response) {
              $.ajax({
                  url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_sku=' +  encodeURIComponent(request),
                  dataType: 'json',
                  success: function(json) {
                      response($.map(json, function(item) {
                          return {
                              label: item['sku'],
                              value: item['product_id']
                          }
                      }));
                  }
              });
          },
          'select': function(item) {
              $('input[name=\'filter_sku\']').val(item['label']);
              $('input[name=\'filter_sku\']').change();
          }
      });

      //$('input[name=\'filter_model\']').autocomplete({
      //	'source': function(request, response) {
      //		$.ajax({
      //			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_model=' +  encodeURIComponent(request),
      //			dataType: 'json',
      //			success: function(json) {
      //				response($.map(json, function(item) {
      //					return {
      //						label: item['model'],
      //						value: item['product_id']
      //					}
      //				}));
      //			}
      //		});
      //	},
      //	'select': function(item) {
      //		$('input[name=\'filter_model\']').val(item['label']);
      //	}
      //});
      //--></script></div>
<?php echo $footer; ?>