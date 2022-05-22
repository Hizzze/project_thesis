<ul class="sidebar-categories">
<?php foreach ($categories as $category) { ?>
<li>
  <a href="<?php echo $category['href']; ?>" class="<?= $category['category_id'] == $category_id ? 'active open' : '' ?><?= $category['children'] ? ' with-child' : '' ?>">
    <?php echo $category['name']; ?>
  </a>
  <?php if ($category['children']) { ?>
  <ul class="sidebar-categories__child">
    <a href="<?php echo $category['href']; ?>" class="<?= $category['category_id'] == $category_id ? ' active' : '' ?>">
      <?= $text['category_current'] ?>
    </a>
    <?php foreach ($category['children'] as $child) { ?>
    <li>
      <a href="<?php echo $child['href']; ?>"<?= $child['category_id'] == $child_id ? ' class="active"' : '' ?>>
        <?php echo $child['name']; ?>
      </a>
    </li>
    <?php } ?>
  </ul>
  <?php } ?>
</li>
<?php } ?>
</ul>