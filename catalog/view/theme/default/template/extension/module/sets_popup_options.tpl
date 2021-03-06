<?php if($options) { ?>
<div id="sets-popup-<?php echo $modal_id;?>" class="modal fade set-options" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $modal_title;?></h4>
            </div>
            <div class="modal-body">

                <?php foreach ($options as $option) { ?>
                <?php if ($option['type'] == 'select') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <select name="option[<?php echo $option['product_option_id']; ?>]" id="set-input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                        <option data-prefix="+" data-price="0" value=""><?php echo $text_select;?></option>
                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <option data-prefix="<?php echo $option_value['price_prefix'];?>" data-price="<?php echo $option_value['cprice'];?>" value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                            <?php if ($option_value['price']) { ?>
                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                            <?php } ?>
                        </option>
                        <?php } ?>
                    </select>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'radio') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label"><?php echo $option['name']; ?></label>
                    <div id="set-input-option<?php echo $option['product_option_id']; ?>">
                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <div class="radio">
                            <label>
                                <input data-prefix="<?php echo $option_value['price_prefix'];?>" data-price="<?php echo $option_value['cprice'];?>" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                <?php echo $option_value['name']; ?>
                                <?php if ($option_value['price']) { ?>
                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                <?php } ?>
                            </label>
                        </div>
                        <?php } ?>
                    </div>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'checkbox') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label"><?php echo $option['name']; ?></label>
                    <div id="set-input-option<?php echo $option['product_option_id']; ?>">
                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <div class="checkbox">
                            <label>
                                <input data-prefix="<?php echo $option_value['price_prefix'];?>" data-price="<?php echo $option_value['cprice'];?>" type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                <?php if ($option_value['image']) { ?>
                                <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> 
                                <?php } ?>
                                <?php echo $option_value['name']; ?>
                                <?php if ($option_value['price']) { ?>
                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                <?php } ?>
                            </label>
                        </div>
                        <?php } ?>
                    </div>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'image') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label"><?php echo $option['name']; ?></label>
                    <div id="set-input-option<?php echo $option['product_option_id']; ?>">
                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <div class="radio">
                            <label>
                                <input data-prefix="<?php echo $option_value['price_prefix'];?>" data-price="<?php echo $option_value['cprice'];?>" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
                                <?php if ($option_value['price']) { ?>
                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                <?php } ?>
                            </label>
                        </div>
                        <?php } ?>
                    </div>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'text') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="set-input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'textarea') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="set-input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'file') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label"><?php echo $option['name']; ?></label>
                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" class='form-control' id="set-input-option<?php echo $option['product_option_id']; ?>" />
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'date') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <input type="date" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>"  id="set-input-option<?php echo $option['product_option_id']; ?>" class="form-control" />

                </div>
                <?php } ?>
                <?php if ($option['type'] == 'datetime') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <input type="datetime" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" id="set-input-option<?php echo $option['product_option_id']; ?>" class="form-control" />

                </div>
                <?php } ?>
                <?php if ($option['type'] == 'time') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <input type="time" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" id="set-input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                </div>
                <?php } ?>
                <?php } ?>
                <button class='btn btn-success apply-options pull-right'><i class="fa fa-check"></i></button>
                <div class='clearfix'></div>
            </div>
        </div>

    </div>

</div>
<?php } ?>