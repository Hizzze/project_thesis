<div class="container">
    <div class="row">
        <?php if($column_left): ?>
        <div class="col-md-3">
            <?= $column_left ?>
        </div>
        <?php endif; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-12 col-md-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div class="<?= $class ?>">
            <?php echo $content_top; ?>
            <div class="home_category">
                <div class="row">
                    <!-- .home_category-item.col-lg-2*18>.home_category-item-img+span{Профессиональные тренажеры} -->

                    <?php foreach($categories as $category): ?>
                    <a href="<?= $category['href'] ?>" class="home_category-item col-md-2 col-sm-3">
                        <img src="<?= $category['image'] ?>" alt=""><span><?= $category['name'] ?></span>
                    </a>
                    <?php endforeach; ?>

                </div>
            </div>
        </div>
        <?php if($column_right): ?>
        <div class="col-md-3">
            <?= $column_right ?>
        </div>
        <?php endif; ?>
    </div>
    <?php echo $content_bottom; ?>
</div>