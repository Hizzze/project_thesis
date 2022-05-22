<div class="panel panel-default">
	<div class="panel-heading"><?php echo $text_payment_method_title ?></div>
  <div class="panel-content">
  <?php if($error_warning){ ?>
<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($payment_methods) { ?>
<div class="row">
  <?php foreach ($payment_methods as $payment_method) { ?>
    <label class="col-lg-6 checkout-radio">
      <?php if ($payment_method['code'] == $code || !$code) { ?>
      <?php $code = $payment_method['code']; ?>
        <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" checked="checked" />
      <?php } else { ?>
        <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" />
      <?php } ?>
      <?php if($payment_method['image']){ ?>
        <img class="checkout-radio__image" src="<?php echo $payment_method['image']; ?>"/>
      <?php } ?>
      <?php if($tmdqc_payment_label) { ?>
        <div class="checkout-radio__title"><?php echo $payment_method['title']; ?></div>
      <?php } ?>
      <?php if(!empty($payment_method['terms'])){ ?>
      <div class="checkout-radio__price">
      (<?php echo $payment_method['terms']; ?>)
      </div>
      <?php } ?>
    </label>
  <?php } ?>
  <?php } ?>
  </div>
<div class="row <?php echo $tmdqc_payment_comment ?>">
	<div class="col-sm-12">
		<label class="control-label"><?php echo $text_comments; ?></label>
		<textarea name="comment" rows="8" class="form-control"><?php echo $comment; ?></textarea>
	</div>
</div>
<?php if($text_agree){ ?>
<div class="buttons">
  <div class="pull-right"><?php echo $text_agree; ?>
    <?php if ($agree) { ?>
    <input type="checkbox" name="agree" value="1" checked="checked" />
    <?php } else { ?>
    <input type="checkbox" name="agree" value="1" />
    <?php } ?>
    &nbsp;
  </div>
</div>
<?php } ?>

  </div>
</div>