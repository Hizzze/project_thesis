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

<form action="<?php echo $action; ?>" method="post">
  <input type="hidden" name="operation_xml" value="<?php echo $xml; ?>">
  <input type="hidden" name="signature" value="<?php echo $signature; ?>">
  <div class="buttons">
    <div class="pull-right">
      <input type="submit" value="<?= $text['summary_pay'] ?>" class="pay_btn" />
    </div>
  </div>
</form>
