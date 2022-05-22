<?php if (count($languages) > 1): ?>
<div class="header-top-lang">
    <?php foreach ($languages as $language): ?>
    <div onclick="changeLang('<?= $language['code'] ?>')" class="header-top-lang__item<?= $code === $language['code'] ? ' header-top-lang__item--active' : '' ?>"><?= $language['code'] ?></div>
    <?php endforeach; ?>
    <form action="<?php echo $action; ?>" method="post" class="header-top-lang__form" id="form-language">
        <input type="hidden" name="code" value="" id="form-language-code" />
        <input type="hidden" name="redirect" value="<?php echo $redirect; ?>">
    </form>
</div>
<?php endif; ?>