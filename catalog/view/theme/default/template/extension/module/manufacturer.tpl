<?php if( count( $manufacturers ) > 0 ): ?>
<div class="sidebar">
    <?php foreach ($manufacturers as $manufacturer) { ?>
    <a href="<?php echo $manufacturer['href']; ?>"><?php echo $manufacturer['name']; ?></a>
    <?php } ?>
</div>
<?php endif; ?>
