<div class='set' key='<?php echo $key;?>'>
    <table class='table table-bordered'>
        <tr>
            <td>
                <?php echo $entry_product_name;?>
            </td>
            <td>
                <?php echo  $entry_product_quantity;?>
            </td>
            <td>
                <?php echo $entry_product_options;?>
            </td>
            <td>
                <button class='btn btn-danger del_set' class=''><i class='fa fa-close'></i></button>
            </td>
        </tr>
        <?php

        $i=1;

        foreach($products as $product) { 
        ?>
        <tr class='product_row'>
            <td class='product_name'>
                <input type='text' class='form-control' readonly name='set[<?php echo $key;?>][products][<?php echo $i;?>][product_name]' value='<?php echo $product["product_name"];?>'>
                <input type='hidden' name='set[<?php echo $key;?>][products][<?php echo $i;?>][product_id]' value='<?php echo $product["product_id"];?>'>
            </td>

            <td class='quantity'>
                <input type='number' name='set[<?php echo $key;?>][products][<?php echo $i;?>][quantity]' min='1' value='<?php echo $product["quantity"];?>' class='form-control'>
            </td>

            <td class='options'>

                <?php if($product['options']) { ?>
                <select  class='form-control' name='set[<?php echo $key;?>][products][<?php echo $i;?>][use_option]'>
                    <option <?php if($product["use_option"]=='no') { ?> selected <?php } ?> value='no'>NO options</option>
                    <option <?php if($product["use_option"]=='popup') { ?> selected <?php } ?> value='popup'>POPUP options</option>
                    <option <?php if($product["use_option"]=='fixed') { ?> selected <?php } ?> value='fixed'>FIXED options</option>
                </select>
                <button type='button' class='btn btn-info' data-toggle='modal' data-target='#myModalset<?php echo $key;?><?php echo $i;?>'><i class='fa fa-gear'></i></button>
                <!-- Modal -->

                <div id='myModalset<?php echo $key;?><?php echo $i;?>' class='modal fade' role='dialog'>
                    <div class='modal-dialog'>

                        <!-- Modal content-->
                        <div class='modal-content'>
                            <div class='modal-header'>

                                <button type='button' class='close' data-dismiss='modal'>&times;</button>

                            </div>
                            <div class='modal-body'>


                                <div class='col-sm-12'>
                                    <?php foreach ($product['options'] as $option) { 
                                    if(isset($product['option'][$option['product_option_id']]))
                                    $saved_val=$product['option'][$option['product_option_id']];
                                    else
                                    $saved_val=null;
                                    ?>

                                    <?php if($option['type'] == 'select') { ?>
                                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                        <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                        <select name="set[<?php echo $key;?>][products][<?php echo $i;?>][option][<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                                            <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                            <option value="<?php echo $option_value['product_option_value_id']; ?>" <?php if($saved_val==$option_value['product_option_value_id']) { ?> selected <?php } ?>>
                                                    <?php echo $option_value['name']; ?>
                                                    <?php if((int)$option_value['price']) { ?>
                                                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                    <?php } ?>
                                        </option>
                                        <?php } ?>
                                    </select>
                                </div>
                                <?php } ?>

                                <?php if($option['type'] == 'radio') { ?>
                                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label"><?php echo $option['name']; ?></label>
                                    <div id="input-option<?php echo $option['product_option_id']; ?>">
                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                        <div class="radio">
                                            <label>
                                                <input type="radio" <?php if($saved_val==$option_value['product_option_value_id']) { ?> checked <?php } ?> name="set[<?php echo $key;?>][products][<?php echo $i;?>][option][<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                       <?php echo $option_value['name']; ?>
                                                       <?php if((int)$option_value['price']) { ?>
                                                       (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                       <?php } ?>
                                            </label>
                                        </div>
                                        <?php } ?>
                                    </div>
                                </div>
                                <?php } ?>

                                <?php if($option['type'] == 'checkbox') { ?>
                                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label"><?php echo $option['name']; ?></label>
                                    <div id="input-option<?php echo $option['product_option_id']; ?>">
                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" <?php if(is_array($saved_val) && array_search($option_value['product_option_value_id'],$saved_val)!==false) { ?> checked <?php } ?> name="set[<?php echo $key;?>][products][<?php echo $i;?>][option][<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                       <?php if(isset($option_value['image']) && !empty($option_value['image'])) { ?>
                                                       <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> 
                                                <?php } ?>
                                                <?php echo $option_value['name']; ?>
                                                <?php if((int)$option_value['price']) { ?>
                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                <?php } ?>
                                            </label>
                                        </div>
                                        <?php } ?>
                                    </div>
                                </div>
                                <?php } ?>

                                <?php if($option['type'] == 'image') { ?>
                                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label"><?php echo $option['name']; ?></label>
                                    <div id="input-option<?php echo $option['product_option_id']; ?>">
                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                        <div class="radio">
                                            <label>
                                                <input <?php if($saved_val==$option_value['product_option_value_id']) { ?> checked <?php } ?> type="radio" name="set[<?php echo $key;?>][products][<?php echo $i;?>][option][<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                    <?php if(isset($option_value['image']) && !empty($option_value['image'])) { ?>
                                                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
                                                <?php } ?>
                                                <?php if((int)$option_value['price']) { ?>
                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                <?php } ?>
                                            </label>
                                        </div>
                                        <?php } ?>
                                    </div>
                                </div>
                                <?php } ?>
                                <?php if($option['type'] == 'text' || $option['type'] == 'file') { ?>
                                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                    <input type="text" name="set[<?php echo $key;?>][products][<?php echo $i;?>][option][<?php echo $option['product_option_id']; ?>]" value="<?php echo $saved_val; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                </div>
                                <?php } ?>
                                <?php if($option['type'] == 'textarea') { ?>
                                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                    <textarea name="set[<?php echo $key;?>][products][<?php echo $i;?>][option][<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $saved_val; ?></textarea>
                                </div>
                                <?php } ?>

                                <?php if($option['type'] == 'date') { ?>
                                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                    
                                        <input type="date" name="set[<?php echo $key;?>][products][<?php echo $i;?>][option][<?php echo $option['product_option_id']; ?>]" value="<?php echo $saved_val; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                    
                                </div>
                                <?php } ?>
                                <?php if($option['type'] == 'datetime') { ?>
                                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                   
                                        <input type="datetime" name="set[<?php echo $key;?>][products][<?php echo $i;?>][option][<?php echo $option['product_option_id']; ?>]" value="<?php echo $saved_val; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                    
                                </div>
                                <?php } ?>
                                <?php if($option['type'] == 'time') { ?>
                                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                   
                                        <input type="time" name="set[<?php echo $key;?>][products][<?php echo $i;?>][option][<?php echo $option['product_option_id']; ?>]" value="<?php echo $saved_val; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                   
                                </div>
                                <?php } ?>
                                <?php } ?>
                            </div>
                            <div class='clearfix'></div>

                        </div>
                    </div>

                </div>
            </div>
            <?php } else { ?>
            <select class='form-control' name='set[<?php echo $key;?>][products][<?php echo $i;?>][use_option]'>
                <option value='no'>NO options</option>
            </select>
            <?php } ?>
        </td>
        <?php if($i>1) { ?>
        <td class='delete'>
            <button class='btn btn-warning del_product'><i class='fa fa-minus'></i></button>
        </td>
        <?php } ?>
    </tr>
    <?php 
    $i++;
    } ?>

    <tr class='search_row'>
        <td class='search_product_name' colspan='5'>
            <input type='text' name='product_name' class='form-control'>
        </td>
    </tr>

    <tr class='total'>
        <td>
            <?php echo $entry_discount;?>
        </td>
        <td class='old_summ'>
            <input class='form-control' type='text' name='set[<?php echo $key;?>][discount]' value='<?php echo $discount;?>'>
        </td>
        <td>

        </td>

        <td>

        </td>
    </tr>
</table>
</div>