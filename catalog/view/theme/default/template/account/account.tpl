 <?php echo $header; ?>
<div class="container">
  <ul class="bread">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="account_info <?php echo $class; ?>"><?php echo $content_top; ?>
      <h2 class="title"><?php echo $text_my_account; ?></h2>
      <div class="col-lg-12">
        <ul class="account">
          <li><a href="<?php echo $edit; ?>">
          <img src="catalog/view/theme/default/image/account-icon-3.png" alt="">
          <div>
            <span><?= $text['account_about_me'] ?><!-- Обо мне --></span>
            <p><?php echo $text_edit; ?></p>
          </div></a></li>
          <li><a href="<?php echo $password; ?>">
          <img src="catalog/view/theme/default/image/account-icon-4.png" alt="">
          <div>
            <span><?= $text['account_settings'] ?><!-- Настройки --></span>
            <p><?php echo $text_password; ?></p>
          </div>
          </a></li>
          <li><a href="<?php echo $address; ?>">
          <img src="catalog/view/theme/default/image/account-icon-10.png" alt="">
            <div>
              <span><?= $text['account_addresses'] ?><!-- Мои адреса --></span>
              <p><?php echo $text_address; ?></p>
            </div>
          </a></li>
          <li><a href="<?php echo $wishlist; ?>">
          <img src="catalog/view/theme/default/image/account-icon-5.png" alt="">
          <div>
            <span><?= $text['account_wishlist'] ?><!-- Закладки --></span>
            <p><?php echo $text_wishlist; ?></p>
          </div>
          </a></li>
          <li><a href="<?php echo $order; ?>">
          <img src="catalog/view/theme/default/image/account-icon-1.png" alt="">
          <div>
            <span><?php echo $text_order; ?></span>
            <p><?= $text['account_orders'] ?><!-- Статус и история Ваших заказов --></p>
          </div>
          </a></li>
          <li><a href="<?php echo $logout; ?>">
          <img src="catalog/view/theme/default/image/account-icon-8.png" alt="">
          <div>
            <span><?= $text['account_logout'] ?><!-- Выход --></span>
            <p><?php echo $text_logout; ?></p>
          </div>
          </a></li>
        </ul>
      </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?> 