<?php if($options) { ?>
<div id="sets-popup-<?php echo $modal_id;?>" class="modal fade options" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $modal_title;?></h4>
            </div>
            <div class="modal-body">
                <table class='table table-bordered'>
                    <?php foreach($options as $key=>$val) { ?>
                    <tr>
                        <td><?php echo $val['name'];?></td>
                        <td>
                            <?php if(is_array($val['value'])) { ?>
                                <?php echo implode($val['value'],',');?>
                                
                                <?php foreach($val['value'] as $key2=>$val2) { ?>
                                    <?php if($val['type']!=='checkbox') { ?>
                                        <input id='set-input-option<?php echo $key;?>' type='hidden' name='option[<?php echo $key;?>]' value='<?php echo $key2;?>'>
                                    <?php } else { ?>
                                        <input id='set-input-option<?php echo $key;?>' type='hidden' name='option[<?php echo $key;?>][]' value='<?php echo $key2;?>'>
                                    <?php } ?>
                                <?php } ?>
                            <?php } else { ?>
                                <?php echo $val['value'];?>
                                <input id='set-input-option<?php echo $key;?>' type='hidden' name='option[<?php echo $key;?>]' value='<?php echo $val['value'];?>'>
                            <?php } ?>
                        </td>
                    </tr>

                    <?php } ?>

                </table>
            </div>
        </div>
    </div>
</div>
<?php } ?>