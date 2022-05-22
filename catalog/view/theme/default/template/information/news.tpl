<?php echo $header; ?>
<div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="blog-page">
                    <div class="blog-page-header">
                        <a href="/news" class="blog-page-header__back"><span class="icon-arrow-left"></span> <?= $text['blog_header'] ?></a>
						
						
						<div>
                        <h1 class="blog-page-header__title">
                            <?php echo $heading_title; ?>
							</h1>
                        </div>
						
				
                        <div class="blog-page-header__date">
                           <?= $date_added ?>
                        </div>
                    </div>

                    <?php echo $description; ?>

                </div>
            </div>
        </div>
    </div>

<?php echo $footer; ?> 