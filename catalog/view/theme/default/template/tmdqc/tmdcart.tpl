
<?php if ($error_warning) { ?>
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
	<button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <div class="table-responsive checkout-cart">
          <table class="table table-bordered">
              <tr>
								<th colspan="<?php echo $colspn; ?>" class="text-center"><?php echo $heading_title ?></th>
							</tr>
              <tr>
                <?php if($tmdqc_cart_image_status){ ?>
								<td class="text-center"><?php echo $column_image; ?></td>
								<?php } ?>
								<?php if($tmdqc_cart_name_status){ ?>
								<td class="text-left"><?php echo $column_name; ?></td>
								<?php } ?>
								<?php if($tmdqc_cart_model_status){ ?>
                <td class="text-left"><?php echo $column_model; ?></td>
								<?php } ?>
								<?php if($tmdqc_cart_upc_status){ ?>
                <td class="text-left"><?php echo $column_upc; ?></td>
								<?php } ?>
								<?php if($tmdqc_cart_ean_status){ ?>
                <td class="text-left"><?php echo $column_ean; ?></td>
								<?php } ?>
								<?php if($tmdqc_cart_isbn_status){ ?>
                <td class="text-left"><?php echo $column_isbn; ?></td>
								<?php } ?>
								<?php if($tmdqc_cart_qty_status){ ?>
								<td class="text-left"><?php echo $column_quantity; ?></td>
								<?php } ?>
								<?php if($tmdqc_cart_unitprice_status){ ?>
                <td class="text-right"><?php echo $column_price; ?></td>
								<?php } ?>
                <td class="text-right">
                	<?php echo $column_total; ?>
                </td>
              </tr>
              <?php foreach ($products as $product) { ?>
              <tr>
							<?php if($tmdqc_cart_image_status){ ?>
                <td class="text-center"><?php if ($product['thumb']) { ?>
                  <a href="<?php echo $product['href']; ?>">
										<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="checkout-cart__image" />
									</a>
                  <?php } ?></td>
							<?php } ?>
							<?php if($tmdqc_cart_name_status){ ?>
                <td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                  <?php if (!$product['stock']) { ?>
                  <span class="text-danger">***</span>
                  <?php } ?>
                  <?php if ($product['option']) { ?>
										<?php foreach ($product['option'] as $option) { ?>
											<div class="checkout-cart-option">
												<div class="checkout-cart-option__name">
													<?php echo $option['name']; ?>:
												</div>
												<div class="checkout-cart-option__value">
													<?php echo $option['value']; ?>
												</div>
											</div>
										<?php } ?>
                  <?php } ?>
                  <?php if ($product['reward']) { ?>
                  <br />
                  <small><?php echo $product['reward']; ?></small>
                  <?php } ?>
                  <?php if ($product['recurring']) { ?>
                  <br />
                  <span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
                  <?php } ?></td>
								<?php } ?>
								<?php if($tmdqc_cart_model_status){ ?>
                <td class="text-left"><?php echo $product['model']; ?></td>
								<?php } ?>
								<?php if($tmdqc_cart_upc_status){ ?>
                <td class="text-left"><?php echo $product['upc']; ?></td>
								<?php } ?>
								<?php if($tmdqc_cart_ean_status){ ?>
                <td class="text-left"><?php echo $product['ean']; ?></td>
								<?php } ?>
								<?php if($tmdqc_cart_isbn_status){ ?>
                <td class="text-left"><?php echo $product['isbn']; ?></td>
								<?php } ?>
								<?php if($tmdqc_cart_qty_status){ ?>
                <td class="text-left">
									<div class="checkout-cart-control">
                    <input type="text" name="quantity[<?php echo $product['cart_id']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="checkout-cart-control__input" />
                    <span class="checkout-cart-control__buttons">
                    	<button type="submit" class="checkout-cart-control__button" data-toggle="tooltip" title="<?php echo $button_update; ?>">
												<?= $text['refresh'] ?>
											</button>
                    	<button type="button" class="checkout-cart-control__button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" onclick="cartremove('<?php echo $product['cart_id']; ?>');">
												<?= $text['delete'] ?>
											</button>
										</span>
									</div>
								</td>
								<?php } ?>
								<?php if($tmdqc_cart_unitprice_status){ ?>
                <td class="checkout-cart__price"><?php echo $product['price']; ?></td>
								<?php } ?>
                <td class="checkout-cart__total">
                	<span><?php echo $product['total']; ?></span>
                </td>
              </tr>
              <?php } ?>
              <?php foreach ($vouchers as $vouchers) { ?>
              <tr>
                <td></td>
                <td class="text-left"><?php echo $vouchers['description']; ?></td>
                <td class="text-left"></td>
                <td class="text-left">
									<div class="checkout-cart-control">
                    <input type="text" name="" value="1" size="1" disabled="disabled" class="checkout-cart-control__input" />
                    <span class="checkout-cart-control__buttons">
											<button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="checkout-cart-control__button" onclick="voucher.remove('<?php echo $vouchers['key']; ?>');">
												<?= $text['delete'] ?>
											</button>
										</span>
									</div>
								</td>
                <td class="text-right"><?php echo $vouchers['amount']; ?></td>
                <td class="text-right"><?php echo $vouchers['amount']; ?></td>
              </tr>
              <?php } ?>
          </table>
        </div>
      </form>
			<?php if($tmdqc_cart_coupan_status || $tmdqc_cart_gift_status || $permission_reward){ ?>
      <div class="panel-group" id="accordion">
			<!--Coupan--->
			<div class="col-sm-4 pull-right">
			<?php if($tmdqc_cart_coupan_status){ ?>
				<div class="form-group">
						<div class="input-group">
								<input type="text" name="coupon" value="<?php echo $coupon; ?>" placeholder="<?php echo $entry_coupon; ?>" id="input-coupon" class="form-control" />
								<span class="input-group-btn">
								<input type="button" value="<?php echo $button_coupon; ?>" id="button-coupon" data-loading-text="<?php echo $text_loading; ?>"  class="btn btn-primary" />
								</span>
						</div>
			 </div>
			 <?php } ?>
			 <!--coupan End--->
			 <!--Voucher Start-->
			 <?php if($tmdqc_cart_gift_status){ ?>
			 <div class="form-group">
					<div class="input-group">
						<input type="text" name="voucher" value="<?php echo $voucher; ?>" placeholder="<?php echo $entry_voucher; ?>" id="input-voucher" class="form-control" />
						<span class="input-group-btn">
							<input type="submit" value="<?php echo $button_voucher; ?>" id="button-voucher" data-loading-text="<?php echo $text_loading; ?>"  class="btn btn-primary" />
						</span>
					</div>
			 </div>
			  <?php } ?>
			 <!--Voucher End-->
			 <!--Reward Start-->
			 <?php if($permission_reward){ ?>
			 <div class="form-group">
				 <div class="input-group">
						<input type="text" name="reward" value="<?php echo $reward; ?>" placeholder="<?php echo $entry_reward; ?>" id="input-reward" class="form-control" />
						<span class="input-group-btn">
						<input type="submit" value="<?php echo $button_reward; ?>" id="button-reward" data-loading-text="<?php echo $text_loading; ?>"  class="btn btn-primary" />
						</span>
				 </div>
			 </div>
			 <?php } ?>
			 <!--Reward End-->
			</div>
			</div>
      <br />
			<?php } ?>
			<?php if($tmdqc_cart_total_status){ ?>
      <div class="row">
        <div class="col-sm-12 checkout-total">
            <?php foreach ($totals as $total) { ?>
            <p><?php echo $total['title']; ?>:
            <?php echo $total['text']; ?></p>
            <?php } ?>
        </div>
      </div>
			<?php  } ?>
			<script>
			function cartremove(key){
				$.ajax({
					url: 'index.php?route=checkout/cart/remove',
					type: 'post',
					data: 'key=' + key,
					dataType: 'json',
					beforeSend: function() {
						$('#cart > button').toggleClass('loading');
					},
					complete: function() {
						$('#cart > button').toggleClass('loading');
					},
					success: function(json) {
						 setTimeout(function () {
									$('#cart-total ~ .badge').html(json['count']);

									if (json['count'] !== 0) {
											$("#cart-total").addClass("not-empty");
									}
							}, 100);
						
						if (getURLVar('route') == 'tmdqc/tmdcheckout' || window.location.href.indexOf("checkout") > -1) {
							location = 'index.php?route=tmdqc/tmdcheckout';
						} else {
							$('#cart > ul').load('index.php?route=common/cart/info ul li');
						}
					}
				});
			}
			</script>
<!-- 			<script>
					if ($("input:checkbox").is(":checked")) {
						$("input:checkbox").parent().addClass("active");
						console.log("da");
					}
			</script>
			<script>
				$(document).ready(function() {


					if ($("input:checkbox").is(":checked")) {
						$("input:checkbox").parent().addClass("active");
						console.log("da");
					}

					$("label").click(function() {
						var input = $(this).find("input:checkbox");

						if (input.is(":checked")) {
							$(this).addClass("active");
						} else {
							$(this).removeClass("active");
						}
					});

				});
			</script> -->