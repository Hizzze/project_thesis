<?php echo $header; ?>
 <div class="container">
    <?php if($information_id == 8): ?>
      <?php echo $description; ?>
    <?php else: ?>
      <div class="row justify-content-center">
          <div class="col-md-8">
              <div class="blog-page">
                  <h1 class="h2"><?php echo $heading_title; ?></h1>
                  <?php echo $description; ?>
              </div>
          </div>
      </div>
    <?php endif; ?>
        
    </div>

    <?php if($information_id == 8): ?>
    <div class="container">
        <div class="home-form">
            <div class="row">
                <div class="col-lg-3 offset-lg-7 col-md-6 offset-md-3">
                    <form class="form">
                        <div class="h2"><?= $text['bottom_form_header'] ?></div>
                        <div class="form-input">
                            <input type="text" name="name" placeholder="<?= $text['your_name'] ?>">
                        </div>
                        <div class="form-input">
                            <input type="email" name="email" placeholder="<?= $text['your_email'] ?>">
                            <button type="submit"><span class="icon-arrow-right"></span></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <?php endif; ?>
<?php echo $footer; ?>

