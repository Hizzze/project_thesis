<?php echo $header; ?>
 <br/><br/>

<div class="container">
<h1 align="center">Новости интернет-магазина Конверс</h1><br><br>
        <div class="row">
			<?php foreach ($news_list as $news) { ?>
            <div class="col-md-6">
              <a href="<?php echo $news['view']; ?>" class="blog-card">
                  <img src="<?php echo $news['image']; ?>" alt="<?php echo $news['title']; ?>" class="blog-card__img" />
                  <div class="blog-card__title"><?php echo $news['title']; ?></div>
                  <div class="blog-card__date"><?php echo $news['date_added']; ?></div>
                  <div class="blog-card__text">
                      <?php echo $news['description']; ?>
                  </div>
              </a>
          </div>
			<?php } ?>
        </div>

        <?php echo $pagination; ?>
    </div>

<?php echo $footer; ?> 