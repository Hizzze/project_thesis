<?php echo $header; ?><?php echo $column_left; ?>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="/bs-iconpicker/css/bootstrap-iconpicker.min.css" rel="stylesheet">
<script src="//oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="//oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<link href="//cdnjs.cloudflare.com/ajax/libs/lightbox2/2.10.0/css/lightbox.min.css" rel="stylesheet">

<div id="content" style="padding-top: 70px">
    <div class="container">
        <div class="row">
            <div class="col-md-7">
                <div class="panel panel-default">
                    <div class="panel-heading clearfix">
                        <h5 class="pull-left">Меню сайта</h5>
                    </div>
                    <div class="panel-body" id="cont">
                        <ul id="myEditor" class="sortableLists list-group">
                        </ul>
                    </div>
                </div>
                <div class="form-group">
                    <button id="btnOut" type="button" class="btn btn-success"><i class="glyphicon glyphicon-ok"></i>
                        Сохранить
                    </button>
                </div>
                <div class="form-group"><textarea id="out" class="form-control" cols="50" rows="10"></textarea>
                </div>
            </div>
            <div class="col-md-5">
                <div class="panel panel-primary">
                    <div class="panel-heading">Редактирование пункта меню</div>
                    <div class="panel-body">
                        <form id="frmEdit" class="form-horizontal">
                            <div class="form-group">
                                <label for="text" class="col-sm-3 control-label">Текст ссылки</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control item-menu" name="text" id="text"
                                           placeholder="Главная">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="href" class="col-sm-3 control-label">Ссылка</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control item-menu" id="href" name="href"
                                           placeholder="/home">

                                </div>
                            </div>
                            <div class="form-group">
                                <label for="text" class="col-sm-3 control-label">Изображение</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control item-menu" id="input-image2000" name="thumb"
                                           placeholder="/" style="margin-bottom:10px">
                                    <a href="" id="thumb-image2000" data-toggle="image" class="btn btn-primary" type="button">Изменить</a>
                                    <a onclick="openWindow()"
                                       target="_blank" class="btn btn-primary">
                                        Посмотреть
                                    </a>
                                    <a href="" id="image-lightbox" data-lightbox="image-1" data-title="Preview" style="display: none"></a>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="target" class="col-sm-3 control-label">Как открыть</label>
                                <div class="col-sm-9">
                                    <select name="target" id="target" class="form-control item-menu">
                                        <option value="_self">В текущей вкладке</option>
                                        <option value="_blank">В новой вкладке</option>
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="panel-footer">
                        <button type="button" id="btnUpdate" class="btn btn-primary" disabled style="display: none"><i
                                    class="fa fa-refresh"></i>
                            Применить
                        </button>
                        <button type="button" id="btnAdd" class="btn btn-success"><i class="fa fa-plus"></i> Добавить
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src='//cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js'></script>
    <script src='//cdnjs.cloudflare.com/ajax/libs/lightbox2/2.10.0/js/lightbox.min.js'></script>

    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>
    <script src='/bs-iconpicker/jquery-menu-editor.min.js'></script>
    <script src='/bs-iconpicker/js/iconset/iconset-fontawesome-4.7.0.min.js'></script>
    <script src='/bs-iconpicker/js/bootstrap-iconpicker.js'></script>
    <script>
        function openWindow() {
            $('#image-lightbox').attr('href', '/image/' + document.getElementById('input-image2000').value);
            $('#image-lightbox').trigger('click');
        }
        jQuery(document).ready(function () {

            var iconPickerOptions = {searchText: 'Buscar...', labelHeader: '{0} de {1} Pags.'};
            var sortableListOptions = {placeholderCss: {'background-color': 'cyan'}};

            var editor = new MenuEditor('myEditor', {listOptions: sortableListOptions, labelEdit: 'Редактировать'});
            editor.setForm($('#frmEdit'));
            editor.setUpdateButton($('#btnUpdate'));

            $('#btnOut').on('click', function () {
                editor.update();
                var str = editor.getString();

                $.ajax({
                    type: 'POST',
                    data: {
                        "value": str
                    },
                    dataType: 'json',
                    url: '<?= $save; ?>',
                })
                    .always(function() {
                        if(toastr){
                            toastr.success('Информация обновлена - сохрание её')
                        } else {
                            alert('Информация обновлена - сохрание её')
                        }
                    });
                $("#out").text(str);
            });

            $("#btnUpdate").click(function () {
                editor.update();
            });

            $('#btnAdd').click(function () {
                editor.add();
            });

            editor.setData(<?= json_encode($menu);?>);
        });
    </script>
    <?php echo $footer; ?>
