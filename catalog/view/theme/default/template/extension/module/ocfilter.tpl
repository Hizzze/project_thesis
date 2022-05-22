<div class="ocfilter-mobile-button" onclick="toggleMenu('ocfilter')">
  <?= $text['ocfilter_mobile_button'] ?>
</div>

<div class="mobile-menu mobile-menu--ocfilter">
    <div class="mobile-menu__close" onclick="toggleMenu('ocfilter')"></div>


    <?php if ($options || $show_price) { ?>
    <div class="ocfilter" id="ocfilter">
      <div class="hidden" id="ocfilter-button">
        <button class="bdisabled" data-loading-text="<i class='fa fa-refresh fa-spin'></i> Загрузка.."></button>
      </div>
      <div id="ocfilter-content">


          <?php if ($show_price) { # Price filtering ?>
          <div class="ocfilter-option" data-toggle="popover-price">
            <div class="option-name">
              <?php echo $text_price; ?>&nbsp;<?php echo $symbol_left; ?>
              <span id="price-from"><?php echo $min_price_get; ?></span>&nbsp;-&nbsp;<span id="price-to"><?php echo $max_price_get; ?></span><?php echo $symbol_right; ?>
            </div>

            <div class="option-values">
              <div id="scale-price" class="scale ocf-target" data-option-id="p"
                  data-start-min="<?php echo $min_price_get; ?>"
                  data-start-max="<?php echo $max_price_get; ?>"
                  data-range-min="<?php echo $min_price; ?>"
                  data-range-max="<?php echo $max_price; ?>"
                  data-element-min="#price-from"
                  data-element-max="#price-to"
                  data-control-min="#min-price-value"
                  data-control-max="#max-price-value"
                  ></div>

              <?php if ($diagram) { ?>
              <div class="price-diagram">
                <div class="diagram-field">
                  <svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="100%" height="40px">
                    <?php foreach ($diagram['circles'] as $circle) { ?>
                    <?php if ($circle['count']) { ?>
                    <circle cx="<?php echo $circle['x']; ?>" cy="<?php echo $circle['y']; ?>" r="1" fill="#037a9c" stroke="#037a9c" stroke-width="1" />
                    <?php } else { ?>
                    <circle cx="<?php echo $circle['x']; ?>" cy="<?php echo $circle['y']; ?>" r="1" fill="#BF0000" stroke="#BF0000" stroke-width="1" />
                    <?php } ?>
                    <?php } ?>
                    <path fill="#037a9c" stroke="#037a9c" d="<?php echo $diagram['path']; ?>" stroke-width="1" opacity="0.25" stroke-opacity="1" />
                  </svg>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>
          <?php } # Price filtering end ?>

          <?php foreach ($options as $option) { ?>

          <?php if ($show_options_limit && $show_options_limit == $option['index'] - 1) { ?>
          <?php if ($show_options) { ?>
          <button type="button" class="btn btn-default btn-block" data-toggle="collapse" data-target="#ocfilter-hidden-options" aria-expanded="true" aria-controls="ocfilter-hidden-options"><i class="fa fa-angle-down"></i></button>
          <div class="collapse in" id="ocfilter-hidden-options" aria-expanded="true">
          <?php } else { ?>
          <button type="button" class="btn btn-default btn-block" data-toggle="collapse" data-target="#ocfilter-hidden-options" aria-expanded="false" aria-controls="ocfilter-hidden-options"><i class="fa fa-angle-down"></i></button>
          <div class="collapse" id="ocfilter-hidden-options" aria-expanded="false">
          <?php } ?>
          <?php } ?>

            <div class="ocfilter-option" id="option-<?php echo $option['option_id']; ?>">
              <div class="option-name">
                <?php echo $option['name']; ?>

    <!--
                <?php if ($option['type'] == 'slide' || $option['type'] == 'slide_dual') { ?>
                <span id="left-value-<?php echo $option['option_id']; ?>"><?php echo $option['slide_value_min_get']; ?></span>
                -&nbsp;<span id="right-value-<?php echo $option['option_id']; ?>"><?php echo $option['slide_value_max_get']; ?></span>
                <?php echo $option['postfix']; ?>
                <?php } ?>
                -->
                <span class="slide"></span>
              </div>



              <?php if($option['option_id'] == 30134):  // SIZE ?>
            
              <div class="option-values option-values--sizes">

                <?php foreach ($option['values'] as $key => $value) { ?>

                <?php if ($show_values_limit && $show_values_limit == $key) { ?>
                <p>
                  <a href="#ocfilter-hidden-values-<?php echo $option['option_id']; ?>" data-toggle="collapse" aria-expanded="false" aria-controls="ocfilter-hidden-values"><?php echo $text_show_all; ?> <i class="fa fa-angle-down"></i></a>
                </p>
                <div class="collapse" id="ocfilter-hidden-values-<?php echo $option['option_id']; ?>">
                <?php } ?>


                  <?php if ($value['selected']) { ?>

                  <label id="v-<?php echo $value['id']; ?>" class="selected">
                    <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="<?php echo $value['href']; ?>" checked="checked" class="ocf-target" />
                    <a href="<?php echo $value['href']; ?>"><?php echo $value['name']; ?></a>
                    <?php if ($show_counter) { ?>
                    <small></small>
                    <?php } ?>
                  </label>

                  <?php } elseif ($value['count']) { ?>

                  <label id="v-<?php echo $value['id']; ?>">
                    <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="<?php echo $value['href']; ?>" class="ocf-target" />
                    <a href="<?php echo $value['href']; ?>"><?php echo $value['name']; ?></a>
                    <?php if ($show_counter) { ?>
                    <small>(<?php echo $value['count']; ?>)</small>
                    <?php } ?>
                  </label>

                  <?php } else { ?>

                  <label id="v-<?php echo $value['id']; ?>" class="disabled">
                    <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="" disabled="disabled" class="ocf-target" />
                    <?php echo $value['name']; ?>
                    <?php if ($show_counter) { ?>
                    <small>(0)</small>
                    <?php } ?>
                  </label>

                  <?php } ?>

                <?php if ($show_values_limit && $show_values_limit < count($option['values']) && $key + 1 == count($option['values'])) { ?>
                </div>
                <?php } ?>

                <?php } ?>
              </div>

              <?php elseif($option['option_id'] == 30133): // COLOR ?>


    <div class="option-values option-values--colors">

                <?php foreach ($option['values'] as $key => $value) { ?>

                <?php if ($show_values_limit && $show_values_limit == $key) { ?>
                <p>
                  <a href="#ocfilter-hidden-values-<?php echo $option['option_id']; ?>" data-toggle="collapse" aria-expanded="false" aria-controls="ocfilter-hidden-values"><?php echo $text_show_all; ?> <i class="fa fa-angle-down"></i></a>
                </p>
                <div class="collapse" id="ocfilter-hidden-values-<?php echo $option['option_id']; ?>">
                <?php } ?>


                  <?php if ($value['selected']) { ?>

                  <label id="v-<?php echo $value['id']; ?>" class="selected">
                    <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="<?php echo $value['href']; ?>" checked="checked" class="ocf-target" />
                    <a href="<?php echo $value['href']; ?>" style="background: <?php echo $value['name']; ?>"></a>
                  </label>

                  <?php } elseif ($value['count']) { ?>

                  <label id="v-<?php echo $value['id']; ?>">
                    <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="<?php echo $value['href']; ?>" class="ocf-target" />
                    <a href="<?php echo $value['href']; ?>" style="background: <?php echo $value['name']; ?>"></a>
                  </label>

                  <?php } else { ?>

                  <label id="v-<?php echo $value['id']; ?>" class="disabled">
                    <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="" disabled="disabled" class="ocf-target" />
                    <span style="background: <?php echo $value['name']; ?>"></span>
                  </label>

                  <?php } ?>

                <?php if ($show_values_limit && $show_values_limit < count($option['values']) && $key + 1 == count($option['values'])) { ?>
                </div>
                <?php } ?>

                <?php } ?>
              </div>


              <?php else: ?>
              
              <div class="option-values custom_filter">
                <?php if ($option['selectbox'] && ($option['type'] == 'radio' || $option['type'] == 'checkbox')) { # Selectbox wrapper start ?>
                <div class="dropdown">
                  <button class="btn btn-block btn-<?php echo (isset($selecteds[$option['option_id']]) ? 'warning' : 'default'); ?> dropdown-toggle" type="button" id="ocfilter-selectbox-<?php echo $option['option_id']; ?>" data-toggle="dropdown" aria-expanded="true">
                    <i class="pull-right fa fa-angle-down"></i>
                    <span class="pull-left text-left">
                      <?php if (isset($selecteds[$option['option_id']])) { ?>
                      <?php foreach ($selecteds[$option['option_id']]['values'] as $value) { ?>
                      <?php echo $value['name']; ?><br />
                      <?php } ?>
                      <?php } else { ?>
                      <?php echo $text_any; ?>
                      <?php } ?>
                    </span>
                  </button>
                  <ul class="dropdown-menu" role="menu" aria-labelledby="ocfilter-selectbox-<?php echo $option['option_id']; ?>">
                    <li role="presentation">
                <?php } ?>

                <?php if ($option['type'] == 'select') { # Select type start ?>

                <select class="form-control ocf-target<?php echo ($option['selected'] ? ' selected' : ''); ?>">
                  <?php foreach ($option['values'] as $value) { ?>
                  <?php if ($value['selected']) { ?>
                  <option value="<?php echo $value['href']; ?>" id="v-<?php echo $value['id']; ?>" selected="selected"><?php echo $value['name']; ?></option>
                  <?php } elseif ($value['count']) { ?>
                  <option value="<?php echo $value['href']; ?>" id="v-<?php echo $value['id']; ?>"><?php echo $value['name']; ?></option>
                  <?php } else { ?>
                  <option value="" id="v-<?php echo $value['id']; ?>" disabled="disabled"><?php echo $value['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>

                <?php } elseif ($option['type'] == 'slide' || $option['type'] == 'slide_dual') { # Slide type start ?>


              <div class="form-inline">
                <div class="form-group">
                  От
                  <input name="price[min]" value="<?php echo $option['slide_value_min_get']; ?>" type="text" class="form-control input-sm" id="min-price-value-<?php echo $option['option_id']; ?>" />
                </div>
                <div class="form-group">
                  До
                  <input name="price[max]" value="<?php echo $option['slide_value_max_get']; ?>" type="text" class="form-control input-sm" id="max-price-value-<?php echo $option['option_id']; ?>" />
                </div>
              </div> 

                <div id="scale-<?php echo $option['option_id']; ?>" class="scale ocf-target"
                  data-option-id="<?php echo $option['option_id']; ?>"
                  data-start-min="<?php echo $option['slide_value_min_get']; ?>"
                  data-start-max="<?php echo $option['slide_value_max_get']; ?>"
                  data-range-min="<?php echo $option['slide_value_min']; ?>"
                  data-range-max="<?php echo $option['slide_value_max']; ?>"
                  data-element-min="#left-value-<?php echo $option['option_id']; ?>"
                  data-element-max="#right-value-<?php echo $option['option_id']; ?>"
                  data-control-min="#min-price-value-<?php echo $option['option_id']; ?>"
                  data-control-max="#max-price-value-<?php echo $option['option_id']; ?>"
                ></div>

                <?php } elseif ($option['type'] == 'radio' || $option['type'] == 'checkbox') { # Radio and Checkbox types start ?>

                <?php foreach ($option['values'] as $key => $value) { ?>

                <?php if ($show_values_limit && $show_values_limit == $key) { ?>
                <p>
                  <a href="#ocfilter-hidden-values-<?php echo $option['option_id']; ?>" data-toggle="collapse" aria-expanded="false" aria-controls="ocfilter-hidden-values"><?php echo $text_show_all; ?> <i class="fa fa-angle-down"></i></a>
                </p>
                <div class="collapse" id="ocfilter-hidden-values-<?php echo $option['option_id']; ?>">
                <?php } ?>

                  <?php if ($option['color']) { ?>
                  <div class="color" style="background-color: #<?php echo $value['color']; ?>;"></div>
                  <?php } ?>

                  <?php if ($option['image']) { ?>
                  <div class="image" style="background-image: url(<?php echo $value['image']; ?>);"></div>
                  <?php } ?>

                  <?php if ($value['selected']) { ?>
                  <label id="v-<?php echo $value['id']; ?>" class="selected">
                    <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="<?php echo $value['href']; ?>" checked="checked" class="ocf-target" />
                    <a href="<?php echo $value['href']; ?>"><?php echo $value['name']; ?></a>
                    <?php if ($show_counter) { ?>
                    <small></small>
                    <?php } ?>
                  </label>
                  <?php } elseif ($value['count']) { ?>
                  <label id="v-<?php echo $value['id']; ?>">
                    <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="<?php echo $value['href']; ?>" class="ocf-target" />
                    <a href="<?php echo $value['href']; ?>"><?php echo $value['name']; ?></a>
                    <?php if ($show_counter) { ?>
                    <small>(<?php echo $value['count']; ?>)</small>
                    <?php } ?>
                  </label>
                  <?php } else { ?>
                  <label id="v-<?php echo $value['id']; ?>" class="disabled">
                    <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="" disabled="disabled" class="ocf-target" />
                    <?php echo $value['name']; ?>
                    <?php if ($show_counter) { ?>
                    <small>(0)</small>
                    <?php } ?>
                  </label>
                  <?php } ?>

                <?php if ($show_values_limit && $show_values_limit < count($option['values']) && $key + 1 == count($option['values'])) { ?>
                </div>
                <?php } ?>

                <?php } ?>

                <?php } # End type switcher ?>

                <?php if ($option['selectbox'] && ($option['type'] == 'radio' || $option['type'] == 'checkbox')) { # Selectbox wrapper end ?>
                    </li>
                  </ul>
                </div>
                <?php } ?>
              </div>

              <?php endif; ?>
            </div>

          <?php if ($show_options_limit && $option['index'] == count($options)) { # Closing the hidden options box ?>
          </div>
          <?php } ?>

          <?php } # End "foreach $options" ?>
        </div>
      </div>
    <?php } ?>
</div>










<?php if ($options || $show_price) { ?>
<div class="ocfilter" id="ocfilter">
  <div class="hidden" id="ocfilter-button">
    <button class="bdisabled" data-loading-text="<i class='fa fa-refresh fa-spin'></i> Загрузка.."></button>
  </div>
  <div id="ocfilter-content">


      <?php if ($show_price) { # Price filtering ?>
      <div class="ocfilter-option" data-toggle="popover-price">
        <div class="option-name">
					<?php echo $text_price; ?>&nbsp;<?php echo $symbol_left; ?>
          <span id="price-from"><?php echo $min_price_get; ?></span>&nbsp;-&nbsp;<span id="price-to"><?php echo $max_price_get; ?></span><?php echo $symbol_right; ?>
				</div>

        <div class="option-values">
					<div id="scale-price" class="scale ocf-target" data-option-id="p"
              data-start-min="<?php echo $min_price_get; ?>"
              data-start-max="<?php echo $max_price_get; ?>"
              data-range-min="<?php echo $min_price; ?>"
              data-range-max="<?php echo $max_price; ?>"
              data-element-min="#price-from"
              data-element-max="#price-to"
              data-control-min="#min-price-value"
              data-control-max="#max-price-value"
              ></div>

					<?php if ($diagram) { ?>
          <div class="price-diagram">
						<div class="diagram-field">
							<svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="100%" height="40px">
								<?php foreach ($diagram['circles'] as $circle) { ?>
								<?php if ($circle['count']) { ?>
								<circle cx="<?php echo $circle['x']; ?>" cy="<?php echo $circle['y']; ?>" r="1" fill="#037a9c" stroke="#037a9c" stroke-width="1" />
								<?php } else { ?>
								<circle cx="<?php echo $circle['x']; ?>" cy="<?php echo $circle['y']; ?>" r="1" fill="#BF0000" stroke="#BF0000" stroke-width="1" />
								<?php } ?>
								<?php } ?>
								<path fill="#037a9c" stroke="#037a9c" d="<?php echo $diagram['path']; ?>" stroke-width="1" opacity="0.25" stroke-opacity="1" />
							</svg>
						</div>
          </div>
					<?php } ?>
        </div>
      </div>
      <?php } # Price filtering end ?>

      <?php foreach ($options as $option) { ?>

			<?php if ($show_options_limit && $show_options_limit == $option['index'] - 1) { ?>
			<?php if ($show_options) { ?>
      <button type="button" class="btn btn-default btn-block" data-toggle="collapse" data-target="#ocfilter-hidden-options" aria-expanded="true" aria-controls="ocfilter-hidden-options"><i class="fa fa-angle-down"></i></button>
      <div class="collapse in" id="ocfilter-hidden-options" aria-expanded="true">
			<?php } else { ?>
      <button type="button" class="btn btn-default btn-block" data-toggle="collapse" data-target="#ocfilter-hidden-options" aria-expanded="false" aria-controls="ocfilter-hidden-options"><i class="fa fa-angle-down"></i></button>
      <div class="collapse" id="ocfilter-hidden-options" aria-expanded="false">
      <?php } ?>
			<?php } ?>

				<div class="ocfilter-option" id="option-<?php echo $option['option_id']; ?>">
	        <div class="option-name">
	          <?php echo $option['name']; ?>

<!--
						<?php if ($option['type'] == 'slide' || $option['type'] == 'slide_dual') { ?>
            <span id="left-value-<?php echo $option['option_id']; ?>"><?php echo $option['slide_value_min_get']; ?></span>
						-&nbsp;<span id="right-value-<?php echo $option['option_id']; ?>"><?php echo $option['slide_value_max_get']; ?></span>
            <?php echo $option['postfix']; ?>
            <?php } ?>
            -->
            <span class="slide"></span>
	        </div>



          <?php if($option['option_id'] == 30134):  // SIZE ?>
        
          <div class="option-values option-values--sizes">

	          <?php foreach ($option['values'] as $key => $value) { ?>

						<?php if ($show_values_limit && $show_values_limit == $key) { ?>
            <p>
              <a href="#ocfilter-hidden-values-<?php echo $option['option_id']; ?>" data-toggle="collapse" aria-expanded="false" aria-controls="ocfilter-hidden-values"><?php echo $text_show_all; ?> <i class="fa fa-angle-down"></i></a>
            </p>
            <div class="collapse" id="ocfilter-hidden-values-<?php echo $option['option_id']; ?>">
						<?php } ?>


							<?php if ($value['selected']) { ?>

		          <label id="v-<?php echo $value['id']; ?>" class="selected">
                <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="<?php echo $value['href']; ?>" checked="checked" class="ocf-target" />
                <a href="<?php echo $value['href']; ?>"><?php echo $value['name']; ?></a>
                <?php if ($show_counter) { ?>
                <small></small>
                <?php } ?>
              </label>

							<?php } elseif ($value['count']) { ?>

		          <label id="v-<?php echo $value['id']; ?>">
                <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="<?php echo $value['href']; ?>" class="ocf-target" />
                <a href="<?php echo $value['href']; ?>"><?php echo $value['name']; ?></a>
                <?php if ($show_counter) { ?>
                <small>(<?php echo $value['count']; ?>)</small>
                <?php } ?>
              </label>

							<?php } else { ?>

		          <label id="v-<?php echo $value['id']; ?>" class="disabled">
                <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="" disabled="disabled" class="ocf-target" />
                <?php echo $value['name']; ?>
                <?php if ($show_counter) { ?>
                <small>(0)</small>
                <?php } ?>
              </label>

		          <?php } ?>

            <?php if ($show_values_limit && $show_values_limit < count($option['values']) && $key + 1 == count($option['values'])) { ?>
      			</div>
						<?php } ?>

	          <?php } ?>
	        </div>

          <?php elseif($option['option_id'] == 30133): // COLOR ?>


<div class="option-values option-values--colors">

	          <?php foreach ($option['values'] as $key => $value) { ?>

						<?php if ($show_values_limit && $show_values_limit == $key) { ?>
            <p>
              <a href="#ocfilter-hidden-values-<?php echo $option['option_id']; ?>" data-toggle="collapse" aria-expanded="false" aria-controls="ocfilter-hidden-values"><?php echo $text_show_all; ?> <i class="fa fa-angle-down"></i></a>
            </p>
            <div class="collapse" id="ocfilter-hidden-values-<?php echo $option['option_id']; ?>">
						<?php } ?>


							<?php if ($value['selected']) { ?>

		          <label id="v-<?php echo $value['id']; ?>" class="selected">
                <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="<?php echo $value['href']; ?>" checked="checked" class="ocf-target" />
                <a href="<?php echo $value['href']; ?>" style="background: <?php echo $value['name']; ?>"></a>
              </label>

							<?php } elseif ($value['count']) { ?>

		          <label id="v-<?php echo $value['id']; ?>">
                <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="<?php echo $value['href']; ?>" class="ocf-target" />
                <a href="<?php echo $value['href']; ?>" style="background: <?php echo $value['name']; ?>"></a>
              </label>

							<?php } else { ?>

		          <label id="v-<?php echo $value['id']; ?>" class="disabled">
                <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="" disabled="disabled" class="ocf-target" />
                <span style="background: <?php echo $value['name']; ?>"></span>
              </label>

		          <?php } ?>

            <?php if ($show_values_limit && $show_values_limit < count($option['values']) && $key + 1 == count($option['values'])) { ?>
      			</div>
						<?php } ?>

	          <?php } ?>
	        </div>


          <?php else: ?>
          
	        <div class="option-values custom_filter">
            <?php if ($option['selectbox'] && ($option['type'] == 'radio' || $option['type'] == 'checkbox')) { # Selectbox wrapper start ?>
            <div class="dropdown">
              <button class="btn btn-block btn-<?php echo (isset($selecteds[$option['option_id']]) ? 'warning' : 'default'); ?> dropdown-toggle" type="button" id="ocfilter-selectbox-<?php echo $option['option_id']; ?>" data-toggle="dropdown" aria-expanded="true">
                <i class="pull-right fa fa-angle-down"></i>
                <span class="pull-left text-left">
                	<?php if (isset($selecteds[$option['option_id']])) { ?>
  								<?php foreach ($selecteds[$option['option_id']]['values'] as $value) { ?>
                  <?php echo $value['name']; ?><br />
  								<?php } ?>
                	<?php } else { ?>
                	<?php echo $text_any; ?>
                	<?php } ?>
                </span>
              </button>
              <ul class="dropdown-menu" role="menu" aria-labelledby="ocfilter-selectbox-<?php echo $option['option_id']; ?>">
                <li role="presentation">
            <?php } ?>

						<?php if ($option['type'] == 'select') { # Select type start ?>

						<select class="form-control ocf-target<?php echo ($option['selected'] ? ' selected' : ''); ?>">
							<?php foreach ($option['values'] as $value) { ?>
	            <?php if ($value['selected']) { ?>
	            <option value="<?php echo $value['href']; ?>" id="v-<?php echo $value['id']; ?>" selected="selected"><?php echo $value['name']; ?></option>
	            <?php } elseif ($value['count']) { ?>
	            <option value="<?php echo $value['href']; ?>" id="v-<?php echo $value['id']; ?>"><?php echo $value['name']; ?></option>
	            <?php } else { ?>
							<option value="" id="v-<?php echo $value['id']; ?>" disabled="disabled"><?php echo $value['name']; ?></option>
							<?php } ?>
	            <?php } ?>
	          </select>

            <?php } elseif ($option['type'] == 'slide' || $option['type'] == 'slide_dual') { # Slide type start ?>


          <div class="form-inline">
            <div class="form-group">
              От
              <input name="price[min]" value="<?php echo $option['slide_value_min_get']; ?>" type="text" class="form-control input-sm" id="min-price-value-<?php echo $option['option_id']; ?>" />
            </div>
            <div class="form-group">
              До
              <input name="price[max]" value="<?php echo $option['slide_value_max_get']; ?>" type="text" class="form-control input-sm" id="max-price-value-<?php echo $option['option_id']; ?>" />
            </div>
          </div> 

						<div id="scale-<?php echo $option['option_id']; ?>" class="scale ocf-target"
              data-option-id="<?php echo $option['option_id']; ?>"
              data-start-min="<?php echo $option['slide_value_min_get']; ?>"
              data-start-max="<?php echo $option['slide_value_max_get']; ?>"
              data-range-min="<?php echo $option['slide_value_min']; ?>"
              data-range-max="<?php echo $option['slide_value_max']; ?>"
              data-element-min="#left-value-<?php echo $option['option_id']; ?>"
              data-element-max="#right-value-<?php echo $option['option_id']; ?>"
              data-control-min="#min-price-value-<?php echo $option['option_id']; ?>"
              data-control-max="#max-price-value-<?php echo $option['option_id']; ?>"
            ></div>

	          <?php } elseif ($option['type'] == 'radio' || $option['type'] == 'checkbox') { # Radio and Checkbox types start ?>

	          <?php foreach ($option['values'] as $key => $value) { ?>

						<?php if ($show_values_limit && $show_values_limit == $key) { ?>
            <p>
              <a href="#ocfilter-hidden-values-<?php echo $option['option_id']; ?>" data-toggle="collapse" aria-expanded="false" aria-controls="ocfilter-hidden-values"><?php echo $text_show_all; ?> <i class="fa fa-angle-down"></i></a>
            </p>
            <div class="collapse" id="ocfilter-hidden-values-<?php echo $option['option_id']; ?>">
						<?php } ?>

	            <?php if ($option['color']) { ?>
							<div class="color" style="background-color: #<?php echo $value['color']; ?>;"></div>
							<?php } ?>

	            <?php if ($option['image']) { ?>
							<div class="image" style="background-image: url(<?php echo $value['image']; ?>);"></div>
							<?php } ?>

							<?php if ($value['selected']) { ?>
		          <label id="v-<?php echo $value['id']; ?>" class="selected">
                <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="<?php echo $value['href']; ?>" checked="checked" class="ocf-target" />
                <a href="<?php echo $value['href']; ?>"><?php echo $value['name']; ?></a>
                <?php if ($show_counter) { ?>
                <small></small>
                <?php } ?>
              </label>
							<?php } elseif ($value['count']) { ?>
		          <label id="v-<?php echo $value['id']; ?>">
                <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="<?php echo $value['href']; ?>" class="ocf-target" />
                <a href="<?php echo $value['href']; ?>"><?php echo $value['name']; ?></a>
                <?php if ($show_counter) { ?>
                <small>(<?php echo $value['count']; ?>)</small>
                <?php } ?>
              </label>
							<?php } else { ?>
		          <label id="v-<?php echo $value['id']; ?>" class="disabled">
                <input type="<?php echo $option['type']; ?>" name="ocfilter_filter[<?php echo $option['option_id']; ?>]" value="" disabled="disabled" class="ocf-target" />
                <?php echo $value['name']; ?>
                <?php if ($show_counter) { ?>
                <small>(0)</small>
                <?php } ?>
              </label>
		          <?php } ?>

            <?php if ($show_values_limit && $show_values_limit < count($option['values']) && $key + 1 == count($option['values'])) { ?>
      			</div>
						<?php } ?>

	          <?php } ?>

	          <?php } # End type switcher ?>

            <?php if ($option['selectbox'] && ($option['type'] == 'radio' || $option['type'] == 'checkbox')) { # Selectbox wrapper end ?>
                </li>
              </ul>
            </div>
            <?php } ?>
	        </div>

          <?php endif; ?>
	      </div>

      <?php if ($show_options_limit && $option['index'] == count($options)) { # Closing the hidden options box ?>
			</div>
			<?php } ?>

    	<?php } # End "foreach $options" ?>
    </div>
  </div>
<script type="text/javascript"><!--
$(function() {
	var options = {
    mobile: true,
    php: {
	    showPrice    : <?php echo $show_price; ?>,
	    showCounter  : <?php echo $show_counter; ?>,
			manualPrice  : <?php echo $manual_price; ?>,
      link         : '<?php echo $link; ?>',
	    path         : '<?php echo $path; ?>',
	    params       : '<?php echo $params; ?>',
	    index        : '<?php echo $index; ?>'
	  },
    text: {
	    show_all: '<?php echo $text_show_all; ?>',
	    hide    : '<?php echo $text_hide; ?>',
	    load    : '<?php echo $text_load; ?>',
			any     : '<?php echo $text_any; ?>',
	    select  : '<?php echo $button_select; ?>'
	  }
	};

  if ($('#ocfilter').is(':hidden')) {
    $('#navbar-ocfilter').html($('#ocfilter').remove().get(0).outerHTML);

    // var html = $('#ocfilter-mobile').remove().get(0).outerHTML;

    // $('.breadcrumb').after(html);

    options['mobile'] = true;
  }

  setTimeout(function() {
    $('#ocfilter').ocfilter(options);
  }, 1);
});
--></script>
<?php } ?>


<script>
  $( ".option-name" ).click(function() {
    $(this).toggleClass('closed');
    $(this).siblings(".option-values").slideToggle( "slow", function() {
      // Animation complete.
    });
});

      $("#column-left button").click(function() {
        console.log("click");
        $("#ocfilter-content").slideToggle( "slow", function() {
        });
      });
</script>