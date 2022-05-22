<?php if($sets_array) { ?>
<script>
    function getDecimal()
    {
        return <?php echo $decimal_place;?>;
        }
</script>

<?php foreach($sets_array as $sets) { ?>
<?php foreach($sets as $iset=>$set) { ?>
<?php foreach($set['products'] as $key=>$product) { ?>
<?php if(isset($product['use_option'])) { ?>
<?php if($product['use_option']=='fixed') { ?>
<?php echo $product['html_options'];?>
<?php } else if($product['use_option']=='popup') { ?>
<?php echo $product['html_options'];?>
<?php } ?>
<?php } ?>
<?php } ?>
<?php } ?>
<?php } ?>

<div class='sets' id='prd-sets'>
    <h3><?php echo $text_sets;?></h3>
    <?php foreach($sets_array as $sets) { ?>
    <div class='sets-slick'>
        <?php foreach($sets as $iset=>$set) { ?>
        <div class="set">
            <input type='hidden' name='economy' value="<?php echo $set['discount'];?>">
            <input type='hidden' name='iset' value="<?php echo $iset;?>">
            <input type='hidden' name='product_id' value="<?php echo $set['product_id'];?>">
            <div class='set_table'>
                <?php $i=0;
                foreach($set['products'] as $key=>$product) { ?>
                <?php if($i++) { ?>
                <div class='cell ao plus'>+</div>
                <?php } ?>
                <div class="cell set-product product<?php echo $product['product_id'].$key;?>" >
                    <input type='hidden' name='cprice' value="<?php echo $product['cprice'];?>">
                    <input type='hidden' name='option_price' value="0">

                    <input type='hidden' name='product_id' value="<?php echo $product['product_id'];?>">
                    <input type='hidden' name='quantity' value="<?php echo $product['quantity'];?>">
                    <?php if($product['thumb']) { ?>
                    <a href="<?php echo $product['href']; ?>"><img src='<?php echo $product['thumb']; ?>' class='img-responsive'></a>
                    <?php } ?>
                    <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['product_name']; ?></a></h4>

                    <span class='new_price'><?php echo $product['price']; ?></span>
                    <?php if($show_qty) { ?>
                    <?php if($product['quantity']>1) { ?>
                    <div class='quantity'>x<?php echo $product['quantity']; ?></div>
                    <?php } ?>
                    <?php } ?>


                    <?php if(isset($product['use_option'])) { ?>
                    <?php if($product['use_option']=='fixed') { ?>
                    <?php echo $product['html_options_button'];?>
                    <?php } else if($product['use_option']=='popup') { ?>
                    <?php echo $product['html_options_button'];?>
                    <?php } else { ?>
                    <input type='hidden' name='option' value='no'>
                    <?php } ?>
                    <?php } else { ?>
                    <input type='hidden' name='option' value='no'>
                    <?php } ?>
                </div>
                <?php } 
                ?>
                <div class='cell ao'>=</div>
                <div class='cell total'>
                    <?php if(isset($set['discount_prec'])) { ?>

                    <div class='disc'><?php echo $set['discount_prec'];?></div>
                    <?php } ?>

                    <span class='economy_text'><?php echo $text_economy;?></span>: <span class='economy_val'><?php echo $set['economy'];?></span>

                    <div class='new_summ'><?php echo $set['new_total']; ?></div>

                    <button class='add-set-btn btn btn-primary' data-success-text="<i class='fa fa-check'></i>" data-loading-text="<i class='fa fa-spinner fa-spin '></i>"><?php echo $text_buy_sets;?></button>
                </div>
            </div>
        </div>
        <?php } ?>
    </div>
    <?php } ?>
</div>


<?php } ?>