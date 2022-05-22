<div class="clearfix">
	<div class="panel panel-default">
		<div class="panel-heading"><?php echo $text_cust ?> <span class="pull-right"><a data-toggle="modal" data-target="#myModal" id="tmdqclogin"><?php echo $text_log_in ?></a></span></div>
    <div class="panel-content checkout-accounttype<?php echo $account_type_show ?>">
  
        <label>
          <?php if ($account == 'register') { ?>
          <input type="radio" name="account" value="register" checked="checked" />
          <?php } else { ?>
          <input type="radio" name="account" value="register" />
          <?php } ?>
          <?php echo $text_register; ?></label>
      <?php if ($checkout_guest){ ?>
      <?php if ($permision){ ?>
        <label>
          <?php if ($account == 'guest') { ?>
          <input type="radio" name="account" value="guest" checked="checked" />
          <?php } else { ?>
          <input type="radio" name="account" value="guest" />
          <?php } ?>
          <?php echo $text_guest; ?></label>
      <?php } ?>
      <?php } ?>
  </div>
  </div>
</div>
<script type="text/javascript"><!--
$('input[name=\'account\']:checked').trigger('click');
//--></script>