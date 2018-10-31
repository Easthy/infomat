<div class="sidebar white-content">
    <div class="p-3 sidebar-item-text d-flex justify-content-between align-items-center">
        Об учреждении <div data-toggle="collapse" href="#menu-expanded" class="item-toggle"></div>
    </div>
    <hr class="m-0">
    <div id="menu-expanded" class="collapse show">
        <div class="p-3 pl-4 sidebar-submenu">
            <a href="/home" class="unstyled">Фото</a>
        </div>
        <hr class="m-0">
        <div class="p-3 pl-4 sidebar-submenu">
            <a href="/schedule" class="unstyled">Режим работы</a>
        </div>
        <hr class="m-0">
        <div class="p-3 pl-4 sidebar-submenu">
            <a href="/home/about" class="unstyled">Описание</a>
        </div>
    </div>
    <hr class="m-0">
    <div class="p-3 sidebar-item-text active">
        <a href="/staff" class="unstyled">Руководство</a>
    </div>
    <hr class="m-0">
    <div class="p-3 sidebar-item-text">
        <a href="/contact" class="unstyled">Контакты</a>
    </div>
</div>

<div class="container-main">

	<div class="block-top white-content">
		<div class="p-3 d-flex justify-content-between">
			<span class="block-top-title">Руководство</span>
            <div class="btn-group form-toggle" data-toggle="modal" data-target="#staffModal">
                <div class="btn btn-dark-green">
                    <img src="/img/icons/plus_white.png">
                </div>
                <div class="btn btn-green">
                    Добавить должность
                </div>
            </div>
		</div>
	</div>

	<div class="block-main white-content p-3">
        
	</div>

</div>


<!-- Modal -->
<div class="modal" id="staffModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <p>Добавить должность</p>
                <img src="/img/icons/modal_close.png" data-dismiss="modal" aria-label="Close" class="modal-close">
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Должность</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="post">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Фамилия</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="surname">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Имя</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="firstname">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Отчество</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="fathername">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Телефон</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="phone">
                        </div>
                    </div>

                    <input type="hidden" name="id">
                    <input type="hidden" name="path">

                    <div class="text-800 text-13 text-design-green">Добавить фото</div>
                    <hr>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-dismiss" data-dismiss="modal">ОТМЕНИТЬ</button>
                <button id="formSubmit" type="button" class="btn btn-save">СОХРАНИТЬ</button>
            </div>
        </div>
    </div>
</div>

<?php echo $this->element('fineuploader'); ?>

<script type="text/javascript">
$(function() {
    function fetchManagement(params) {
        $.ajax({
            url: "/staff/fetchManagement",
            dataType: "json",
            data: params,
            success: function(data) {
                drawManagement(data);
            }
        });
    }

    function prepareModal() {
        $( '.modal form' ).each(function(){
            this.reset();
        });

        $('#uploader-gallery').remove();
        $('.modal form').append('<div id="uploader-gallery" class="row px-3">' +
                                '<div class="uploader-container py-2">' +
                                    '<div id="traditional-uploader">' +
                                '</div></div></div>');
    }

    $('.form-toggle').click(function() {
        prepareModal();
        initUploader('');
        $('.modal form').attr('action', '/staff/create');
    });

    $('body').on('click', '.action-edit', function() {
        prepareModal();
        initUploader($(this).data('id'));
        $('.modal form').attr('action', '/staff/update');
        $.ajax({
            url: "/staff/getManagement",
            dataType: "json",
            data: {'id': $(this).data('id')},
            success: function(data) {
                fillForm(data);
            }
        });
        $('#staffModal').modal('toggle');
    });

    $('body').on('click', '.action-delete', function() {
        $.ajax({
            url: "/staff/delete",
            data: {'id': $(this).data('id')},
            success: function() {
                fetchManagement();
            }
        })
    });

    $('#formSubmit').click(function() {
        $('#staffModal').modal('toggle');

        var data = $('.modal form').serialize();
        var url = $('.modal form').attr('action'); 

        $.ajax({
            method: 'post',
            url: url,
            data: data,
            success: function() {
                fetchManagement();
            }
        });
    });

    function fillForm(data) {
        for (var field_name in data[0][0]){
            if (data[0][0][field_name]) {
                $('form input[name='+field_name+']').val(data[0][0][field_name])
            }
        }
    }

    function drawManagement(management) {
        management_str = '';
        management.forEach(function(manager) {

            management_str += '<div class="row align-items-center">' +
                '<div class="col-2">' +
                    (manager[0]['path'] ? '<img class="img-fluid management-photo" src="/'+manager[0]['path']+'">' : '') +
                '</div>' +
                '<div class="col-3 text-black-small-thick">' +
                    (manager[0]['surname']+' '+manager[0]['firstname']+' '+manager[0]['fathername']) +
                '</div>' +
                '<div class="col-3 text-black-small-thin">' +
                    manager[0]['post'] +
                '</div>' +
                '<div class="col-3 text-black-small-thin">' +
                    (manager[0]['phone'] ? manager[0]['phone'] : '-') +
                '</div>' +
                '<div class="col-1 schedule-text pl-0 ml-0">' +
                    '<img class="action-icon action-delete mr-2" src="/img/icons/delete.png" data-id="'+manager[0]['id']+'">' +
                    '<img class="action-icon action-edit" src="/img/icons/edit.png" data-id="'+manager[0]['id']+'">' +
                '</div>' +
            '</div>' +

            '<hr>';
        });
        
        $('.block-main').html(management_str);
    }

    function initUploader(id) {
        var traditionalUploader = new qq.FineUploader({
            request: {
                endpoint: "/staff/uploadPhoto"
            },
            deleteFile: {
                enabled: true,
                endpoint: "/staff/deletePhoto",
                params: {
                    id: id
                },
                method: 'POST'
            },
            session: {
                endpoint: "/staff/getSession",
                params: {
                    id: id
                }
            },
            validation: {
                allowedExtensions: ['jpg', 'gif', 'png'],
                itemLimit: 1
            },
            element: document.getElementById("traditional-uploader"),
            listElement: document.getElementById("uploader-gallery"),
            callbacks: {
                onComplete: function(id, name, responseJSON) {
                    $('form input[name=path]').val(responseJSON['path']);
                },
                onUpload: function(id, name) {
                    $('.uploader-container').hide();
                },
                onDeleteComplete: function() {
                    $('.uploader-container').show();  
                    $('form input[name=path]').val('');
                },
                onSessionRequestComplete: function(response, success) {
                    if(response.length > 0) {
                        $('.uploader-container').hide();      
                    }
                },
                // onSubmitDelete: function(id) {
                //     if(!$('form input[name=path]').val().includes('img/tmp')) {
                //         $('#uploader-gallery .gallery-preview-item').remove();
                //         $('.uploader-container').show();  
                //         $('form input[name=path]').val('');
                //         this.clearStoredFiles();
                //         return false;
                //     }
                // }
            }
        })
    }

    $('.modal').on('hidden.bs.modal', function () {
        console.log('closed')
    })

    fetchManagement();
});
</script>