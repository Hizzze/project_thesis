<?php echo $header; ?>
  <div class="container">
      <div class="row justify-content-center">
          <div class="col-md-4">
              <div class="thanks">
                  <div class="thanks__title"><?php echo $heading_title; ?></div>
                  <div class="thanks__text">
                      <?php echo $text_message; ?>
                      Мы благодарны вам за заказ. Если у вас остались вопросы, позвоните нам:
                      <a href="tel:+380931234567">+380931234567</a>
                  </div>
      
                  <a href="<?php echo $continue; ?>" class="thanks__btn"><?php echo $button_continue; ?></a>
              </div>
          </div>
      </div>
  </div>
<?php echo $footer; ?>
