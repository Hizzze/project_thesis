<?php if ($reviews) { ?>
  <?php foreach ($reviews as $review) { ?>
  <div class="review">
    <div class="review__name"><?php echo $review['author']; ?></div>
    <div class="review__rating">
        <div class="stars">
            <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($review['rating'] < $i) { ?>
                <span class="icon-star"></span>
                <?php } else { ?>
                    <span class="icon-star active"></span>
                <?php } ?>
            <?php } ?>
        </div>
    </div>
    <div class="review__text">
      <?php echo $review['text']; ?>
    </div>
  </div>
  <?php } ?>
<?php echo $pagination; ?>
<?php } ?>
