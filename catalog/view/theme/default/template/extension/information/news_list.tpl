<?php echo $header; ?>
<div class="container news-page">
  <ul class="bread">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1 class="title"><?php echo $heading_title; ?></h1>


		<div class="news-row">
			<?php foreach ($news_list as $news) { ?>
			<div class="news_item-wrapper">
				<a href="<?php echo $news['view']; ?>" class="news_item">
					<div class="text-center"><img src="<?php echo $news['image']; ?>" /></div>
					<div class="news_item-caption">
						<div class="news_item-title">
							<?php echo $news['title']; ?></div>
						<div class="news_item-descript"><?php echo $news['description']; ?></div>
						<div class="news_item-date"><?php echo $news['date_added']; ?></div>
					</div>
				</a>
			</div>
			<?php } ?>
		</div>

	  <div class="row">
        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
      </div>
	  <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?> 