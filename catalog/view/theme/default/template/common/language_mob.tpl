<?php if (count($languages) > 1): ?>
<div class="header-top-lang header-top-lang--mobile">
    <?php foreach ($languages as $language): ?>
    <div onclick="changeLang('<?= $language['code'] ?>')" class="header-top-lang__item<?= $code === $language['code'] ? ' header-top-lang__item--active' : '' ?>"><?= $language['code'] ?></div>
    <?php endforeach; ?>
</div>
<?php endif; ?>