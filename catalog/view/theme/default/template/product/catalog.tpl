<?php echo $header; ?>
<div class="container height_fix category_wrapper">


	
    <?php if( count( $categories ) > 0 ): ?>
	
    <div class="home_category">

        <div class="row">
            <?php foreach($categories as $category): ?>
            <?php if ($category['category_id'] == $child_id) { ?>
            <a href="<?= $category['href'] ?>" class="home_category-item col-md-2 col-sm-3 active">
                <img src="<?= $category['image'] ?>" alt=""><span><?= $category['name'] ?></span>
            </a>
            <?php } else { ?>
            <a href="<?= $category['href'] ?>" class="home_category-item col-md-2 col-sm-3">
                <img src="<?= $category['image'] ?>" alt=""><span><?= $category['name'] ?></span>
            </a>
            <?php } ?>
            <?php endforeach; ?>
        </div>
    </div>
    <?php endif; ?>
</div>
<?php echo $footer; ?>
