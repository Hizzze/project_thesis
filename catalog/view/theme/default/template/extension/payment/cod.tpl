<table class="table table-bordered">
  <tr>
    <th colspan="2" style="text-align: center; font-weight: bold"><?= $text['summary_header'] ?></th>
  </tr>
  <tr>
    <td style="width: 50%;text-align: right"><?= $text['summary_name'] ?>:</td>
    <td style="width: 50%"><?= $order_info['firstname'] ?></td>
  </tr>
  <tr>
    <td style="width: 50%;text-align: right"><?= $text['summary_phone'] ?>:</td>
    <td style="width: 50%"><?= $order_info['telephone'] ?></td>
  </tr>
  <tr>
    <td style="width: 50%;text-align: right"><?= $text['summary_payment'] ?>:</td>
    <td style="width: 50%"><?= $order_info['payment_method'] ?></td>
  </tr>
  <tr>
    <td style="width: 50%;text-align: right"><?= $text['summary_shipping'] ?>:</td>
    <td style="width: 50%"><?= $order_info['shipping_method'] ?></td>
  </tr>
  <?php if($order_info['email']): ?>
  <tr>
    <td style="width: 50%;text-align: right"><?= $text['summary_email'] ?>:</td>
    <td style="width: 50%"><?= $order_info['email'] ?></td>
  </tr>
  <?php endif; ?>
  <?php if($order_info['comment']): ?>
  <tr>
    <td style="width: 50%;text-align: right"><?= $text['summary_info'] ?>:</td>
    <td style="width: 50%"><?= $order_info['comment'] ?></td>
  </tr>
  <?php endif; ?>
</table>

<div class="buttons">
  <div class="pull-right">
    <input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="buy" data-loading-text="<?php echo $text_loading; ?>" />
  </div>
</div>
<script type="text/javascript"><!--
$('#button-confirm').on('click', function() {
	$.ajax({
		type: 'get',
		url: 'index.php?route=extension/payment/cod/confirm',
		cache: false,
		beforeSend: function() {
			$('#button-confirm').button('loading');
		},
		complete: function() {
			$('#button-confirm').button('reset');
		},
		success: function() {
			location = '<?php echo $continue; ?>';
		}
	});
});
//--></script>
