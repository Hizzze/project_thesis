<table class="table">
  <tr>
    <th colspan="2" style="text-align: center; font-weight: bold">Сводка</th>
  </tr>
  <tr>
    <td style="width: 50%;text-align: right">Имя:</td>
    <td style="width: 50%"><?= $order_info['firstname'] ?></td>
  </tr>
  <tr>
    <td style="width: 50%;text-align: right">Телефон:</td>
    <td style="width: 50%"><?= $order_info['telephone'] ?></td>
  </tr>
  <tr>
    <td style="width: 50%;text-align: right">Способ оплаты:</td>
    <td style="width: 50%"><?= $order_info['payment_method'] ?></td>
  </tr>
  <tr>
    <td style="width: 50%;text-align: right">Способ доставки:</td>
    <td style="width: 50%"><?= $order_info['shipping_method'] ?></td>
  </tr>
  <?php if($order_info['email']): ?>
  <tr>
    <td style="width: 50%;text-align: right">Почта:</td>
    <td style="width: 50%"><?= $order_info['email'] ?></td>
  </tr>
  <?php endif; ?>
  <?php if($order_info['comment']): ?>
  <tr>
    <td style="width: 50%;text-align: right">Информация:</td>
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
		url: 'index.php?route=extension/payment/cheque/confirm',
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
