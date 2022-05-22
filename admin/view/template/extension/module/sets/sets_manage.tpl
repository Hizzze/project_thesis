<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">

    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <!--<button type="submit" form="form-sets_manage" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>-->
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>

    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-sets-manage" class="form-horizontal">
                    <div class=''>
                        <div class='col-sm-6'>
                            <button class='btn btn-success' id="add"><?php echo $btn_add_set;?></button>
                        </div>
                        <div class='col-sm-6'>
                            <button class='btn btn-danger' id="clear"><?php echo $btn_del_set;?></button>
                        </div>
                    </div>
                    <div class='clearfix'></div>
                    <div class='result'></div>


                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="cat"><?php echo $entry_category; ?></label>
                        <div class="col-sm-10">
                            <select name="cat" id="cat" class="form-control">
                                <?php foreach($cats as $cat) { ?>
                                <option value="<?php echo $cat['category_id'];?>" selected="selected"><?php echo $cat['name'];?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_products; ?></label>
                        <div class="col-sm-10">
                            <input name="product_name" class="product_name form-control">
                        </div>
                    </div>

                    <table class="table products table-bordered">
                        <thead>
                            <tr>
                                <td><?php echo $entry_name;?></td>
                                <td><?php echo $entry_qunatity;?></td>
                                <td><?php echo $entry_option;?></td>
                                <td><?php echo $entry_delete;?></td>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td><?php echo $entry_discount;?></td>
                                <td colspan='4'>
                                     <input name="discount" type='text' class="form-control">
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                    

                </form>
            </div>
        </div>
    </div>

</div>
<style>
    .btn
    {
        margin: 0 auto;
        display:table;
    }
    .result
    {
        margin:15px 0;
    }
</style>
<script>
    $('.products').on('click', '.del_product', function () {
        $(this).parents('tr').remove();
        return false;
    });

    $('#form-sets-manage').on('click', '#add', function () {
        var data = $('#form-sets-manage input,#form-sets-manage select,#form-sets-manage checkbox').serialize();

        $.ajax({
            url: 'index.php?route=extension/module/sets_manage/add&token=<?php echo $token; ?>',
            method: 'POST',
            data: data,
            success: function (json) {

                if (json['error']) {
                    $("#form-sets-manage .result").html('<div class=\'alert alert-danger\'>' + json['error'] + '</div>')
                }

                if (json['success']) {
                    $("#form-sets-manage .result").html('<div class=\'alert alert-success\'>' + json['success'] + '</div>')
                }
            }
        });

        return false;
    });

    $('#form-sets-manage').on('click', '#clear', function () {
        var cat_id = $('#form-sets-manage #cat').val();

        $.ajax({
            url: 'index.php?route=extension/module/sets_manage/clear&token=<?php echo $token; ?>',
            method: 'POST',
            data: {cat_id:cat_id},
            success: function (json) {

                if (json['error']) {
                    $("#form-sets-manage .result").html('<div class=\'alert alert-danger\'>' + json['error'] + '</div>')
                }

                if (json['success']) {
                    $("#form-sets-manage .result").html('<div class=\'alert alert-success\'>' + json['success'] + '</div>')
                }
            }
        });

        return false;
    });



    function autocomplete_select(item) {
        var new_row = "<?php echo $row;?>";
        var i = $('.products tbody tr:last').index() + 1 + 1;

        new_row = new_row.replace(/{pi}/g, i);

        new_row = $(new_row);


        $(new_row).find('.product_name input[type="text"]').val(item['label']);
        $(new_row).find('.product_name input[type="hidden"]').val(item['value']);
        $(new_row).find('.old_price input').val(item['price']);
        $(new_row).find('.new_price input').val(item['price']);


        $('.products tbody').append(new_row);
        
        if (item['option'].length)
            $.ajax({
                method: 'POST',
                url: 'index.php?route=extension/module/sets/optionsForms&token=<?php echo $token; ?>',
                data: {options: item['option']},
                success: function (data) {
                    data = data.replace(/set\[{si}\]\[products\]\[{pi}\]/g, 'products[' + i + ']');

                    $(new_row).find('.option .modal-body').html(data);

                    
                }
            });


    }

    function autocomplete_source(request, response) {


        $.ajax({
            url: 'index.php?route=extension/module/sets/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
            dataType: 'json',
            success: function (json) {
                response($.map(json, function (item) {
                    
                    return {
                        label: item['name'],
                        value: item['product_id'],
                        price: item['price'],
                        option: item['option']
                    }
                }));
            }
        });
    }

    $(document).ready(function () {
        $('.product_name').autocomplete({'source': autocomplete_source,'select': autocomplete_select});
    });

</script>
<?php echo $footer; ?>