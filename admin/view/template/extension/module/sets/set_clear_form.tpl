<div class='set' key=''>
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
        <tr class='product_row'>
            <td class='product_name'>
                <input type='text' class='form-control' readonly name='set[{si}][products][1][product_name]' value='<?php echo $product_name;?>'> 
                <input type='hidden' name='set[{si}][products][1][product_id]' value='<?php echo $product_id;?>'>
            </td>
            <td class='quantity'>
                <input type='number' name='set[{si}][products][1][quantity]' min='1' value='1' class='form-control'>
            </td>
            <td class='options'>
                <?php if($options) { ?>
                <select  class='form-control' name='set[{si}][products][1][use_option]'>
                    <option value='no'>NO options</option>
                    <option value='popup'>POPUP options</option>
                    <option value='fixed'>FIXED options</option>
                </select>
                <button type='button' data-toggle='modal' data-target='#myModalset{si}1' class='btn btn-info' ><i class='fa fa-gear'></i></button>
                <!-- Modal -->
                <div id='myModalset{si}1' class='modal fade' role='dialog'>
                    <div class='modal-dialog'>

                        <!-- Modal content-->
                        <div class='modal-content'>
                            <div class='modal-header'>
                                <button type='button' class='close' data-dismiss='modal'>&times;</button>
                            </div>
                            <div class='modal-body'>
                                <div class='col-sm-12'>
                                    <?php foreach ($options as $option) { ?>

                                    <?php if($option['type'] == 'select') { ?>
                                    <div class='form-group<?php echo ($option['required'] ? ' required' : ''); ?>'>
                                         <label class='control-label' for='input-option<?php echo $option['product_option_id']; ?>'><?php echo $option['name']; ?></label>
                                        <select name='set[{si}][products][1][option][<?php echo $option['product_option_id']; ?>]' id='input-option<?php echo $option['product_option_id']; ?>' class='form-control'>
                                                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                <option value='<?php echo $option_value['product_option_value_id']; ?>'><?php echo $option_value['name']; ?>
                                                <?php if((int)$option_value['price']) { ?>
                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                <?php } ?>
                                        </option>
                                        <?php } ?>
                                    </select>
                                </div>
                                <?php } ?>

                                <?php if($option['type'] == 'radio') { ?>
                                <div class='form-group<?php echo ($option['required'] ? ' required' : ''); ?>'>
                                     <label class='control-label'><?php echo $option['name']; ?></label>
                                    <div id='input-option<?php echo $option['product_option_id']; ?>'>
                                         <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                         <div class='radio'>
                                            <label>
                                                <input type='radio' name='set[{si}][products][1][option][<?php echo $option['product_option_id']; ?>]' value='<?php echo $option_value['product_option_value_id']; ?>' />
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
                                <div class='form-group<?php echo ($option['required'] ? ' required' : ''); ?>'>
                                     <label class='control-label'><?php echo $option['name']; ?></label>
                                    <div id='input-option<?php echo $option['product_option_id']; ?>'>
                                         <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                         <div class='checkbox'>
                                            <label>
                                                <input type='checkbox' name='set[{si}][products][1][option][<?php echo $option['product_option_id']; ?>][]' value='<?php echo $option_value['product_option_value_id']; ?>' />
                                                        <?php if(isset($option_value['image']) && !empty($option_value['image'])) { ?>
                                                       <img src='<?php echo $option_value['image']; ?>' alt='<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>' class='img-thumbnail' /> 
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
                                <div class='form-group<?php echo ($option['required'] ? ' required' : ''); ?>'>
                                     <label class='control-label'><?php echo $option['name']; ?></label>
                                    <div id='input-option<?php echo $option['product_option_id']; ?>'>
                                         <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                         <div class='radio'>
                                            <label>
                                                <input type='radio' name='set[{si}][products][1][option][<?php echo $option['product_option_id']; ?>]' value='<?php echo $option_value['product_option_value_id']; ?>' />
                                                       <?php if(isset($option_value['image']) && !empty($option_value['image'])) { ?>
                                                       <img src='<?php echo $option_value['image']; ?>' alt='<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>' class='img-thumbnail' /> 
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

                                <?php if($option['type'] == 'text' || $option['type'] == 'file') { ?>
                                <div class='form-group<?php echo ($option['required'] ? ' required' : ''); ?>'>
                                     <label class='control-label' for='input-option<?php echo $option['product_option_id']; ?>'><?php echo $option['name']; ?></label>
                                    <input type='text' name='set[{si}][products][1][option][<?php echo $option['product_option_id']; ?>]' value='<?php echo $option['value']; ?>' placeholder='<?php echo $option['name']; ?>' id='input-option<?php echo $option['product_option_id']; ?>' class='form-control' />
                                </div>
                                <?php } ?>

                                <?php if($option['type'] == 'textarea') { ?>
                                <div class='form-group<?php echo ($option['required'] ? ' required' : ''); ?>'>
                                     <label class='control-label' for='input-option<?php echo $option['product_option_id']; ?>'><?php echo $option['name']; ?></label>
                                    <textarea name='set[{si}][products][1][option][<?php echo $option['product_option_id']; ?>]' rows='5' placeholder='<?php echo $option['name']; ?>' id='input-option<?php echo $option['product_option_id']; ?>' class='form-control'><?php echo $option['value']; ?></textarea>
                                </div>
                                <?php } ?>

                                <?php if($option['type'] == 'date') { ?>
                                <div class='form-group<?php echo ($option['required'] ? ' required' : ''); ?>'>
                                     <label class='control-label' for='input-option<?php echo $option['product_option_id']; ?>'><?php echo $option['name']; ?></label>
                                    
                                        <input type='date' name='set[{si}][products][1][option][<?php echo $option['product_option_id']; ?>]' value='<?php echo $option['value']; ?>' id='input-option<?php echo $option['product_option_id']; ?>' class='form-control' />
                                    
                                </div>
                                <?php } ?>

                                <?php if($option['type'] == 'datetime') { ?>
                                <div class='form-group<?php echo ($option['required'] ? ' required' : ''); ?>'>
                                     <label class='control-label' for='input-option<?php echo $option['product_option_id']; ?>'><?php echo $option['name']; ?></label>
                                    
                                        <input type='datetime' name='set[{si}][products][1][option][<?php echo $option['product_option_id']; ?>]' value='<?php echo $option['value']; ?>' id='input-option<?php echo $option['product_option_id']; ?>' class='form-control' />
                                    
                                </div>
                                <?php } ?>

                                <?php if($option['type'] == 'time') { ?>
                                <div class='form-group<?php echo ($option['required'] ? ' required' : ''); ?>'>
                                     <label class='control-label' for='input-option<?php echo $option['product_option_id']; ?>'><?php echo $option['name']; ?></label>
                                    
                                        <input type='time' name='set[{si}][products][1][option][<?php echo $option['product_option_id']; ?>]' value='<?php echo $option['value']; ?>' id='input-option<?php echo $option['product_option_id']; ?>' class='form-control' />
                                    
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
            <select  class='form-control' name='set[{si}][products][1][use_option]'>
                <option value='no'>NO options</option>
            </select>

            <?php } ?>
        </td>
    </tr>

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
            <input  class='form-control' type='text' name='set[{si}][discount]' value=''>
        </td>
        <td>

        </td>
    </tr>
</table>
</div>