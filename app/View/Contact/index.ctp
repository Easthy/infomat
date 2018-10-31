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
	<div class="p-3 sidebar-item-text">
		<a href="/staff" class="unstyled">Руководство</a>
	</div>
	<hr class="m-0">
	<div class="p-3 sidebar-item-text active">
		<a href="/contact" class="unstyled">Контакты</a>
	</div>
</div>

<div class="container-main">

	<div class="block-top white-content">
		<div class="p-3 d-flex justify-content-between">
			<span class="block-top-title">Контакты</span>
            <div class="btn-group  form-toggle" data-toggle="modal" data-target="#contactModal">
                <div class="btn btn-dark-green">
                    <img src="/img/icons/plus_white.png">
                </div>
                <div class="btn btn-green">
                    Добавить филиал
                </div>
            </div>
		</div>
	</div>

	<div class="block-main white-content">

	</div>

</div>


<!-- Modal -->
<div class="modal" id="contactModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <p>Редактировать контакты</p>
                <img src="/img/icons/modal_close.png" data-dismiss="modal" aria-label="Close" class="modal-close">
            </div>
            <div class="modal-body">
                <form action="/contact/create">
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Название филиала</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="fullname">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Аббревиатура</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="shortname">
                        </div>
                    </div>
                    
                    <div class="text-800 text-13 text-design-green">Адрес</div>
                    <hr>

                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Индекс</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="address[postal_code]">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Населенный пункт</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="address[city]">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Улица</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="address[street]">
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-sm-2"></div>
                        <div class="col-sm-10 row">
                            <div class="form-group col-sm-3">
                                <label>Дом</label>
                                <input type="text" class="form-control" name="address[house]">
                            </div>
                            <div class="form-group col-sm-3">
                                <label>Корпус</label>
                                <input type="text" class="form-control" name="address[korpus]">
                            </div>
                            <div class="form-group col-sm-3">
                                <label>Строение</label>
                                <input type="text" class="form-control" name="address[building]">
                            </div>
                            <div class="form-group col-sm-3">
                                <label>Офис / квартира</label>
                                <input type="text" class="form-control" name="address[flat]">
                            </div>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Описание проезда</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" rows="3" name="address_comment"></textarea>
                        </div>
                    </div>

                    <div class="text-800 text-13 text-design-green">Контакты</div>
                    <hr>

                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Телефон приемной</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="phone">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Электронная почта</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="www">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Сайт</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email">
                        </div>
                    </div>

                    <input type="hidden" name="id">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-dismiss" data-dismiss="modal">ОТМЕНИТЬ</button>
                <button id="formSubmit" type="button" class="btn btn-save">СОХРАНИТЬ</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
$(function() {
    function fetchContacts(params) {
        $.ajax({
            url: "/contact/fetch",
            dataType: "json",
            data: params,
            success: function(data) {
                drawContacts(data);
            }
        });
    }

    function clearForm() {
        $( '.modal form' ).each(function(){
            this.reset();
        });
    }

    $('body').on('click', '.item-toggle', function() {
        $(this).closest('.row').toggleClass('active');
    });

    $(document).on('click',function(){
        if(!$(event.target).closest('.action-list').length) {
            $(".action-list").removeClass("active");
        }
    });

    $('.form-toggle').click(function() {
        clearForm();
        $('.modal form').attr('action', '/contact/create');
    });

    $('body').on('click', '.action-edit', function() {
        clearForm();
        $('.modal form').attr('action', '/contact/update');
        $.ajax({
            url: "/contact/get",
            dataType: "json",
            data: {'id': $(this).data('id')},
            success: function(data) {
                fillForm(data);
            }
        });
        $('.modal').modal('toggle');
    });

    $('body').on('click', '.action-delete', function() {
        $.ajax({
            url: "/contact/delete",
            data: {'id': $(this).data('id')},
            success: function() {
                fetchContacts();
            }
        })
    });

    $('#formSubmit').click(function() {
        $('.modal').modal('toggle');

        var data = $('.modal form').serialize();
        var url = $('.modal form').attr('action'); 

        $.ajax({
            method: 'post',
            url: url,
            data: data,
            success: function() {
                fetchContacts();
            }
        });
    });

    function fillForm(data) {
        for (var field_name in data[0][0]){
            if (data[0][0][field_name]) {
                if($('form input[name='+field_name+']').length) {
                    $('form input[name='+field_name+']').val(data[0][0][field_name])
                } else {
                    $('form textarea[name='+field_name+']').val(data[0][0][field_name])
                }
            }
        }
    }

    function drawContacts(contacts) {
        contacts_str = '';
        contacts.forEach(function(contact) {
            contacts_str += '<div class="align-items-center row p-3">' +
                '<div class="text-14 text-600 highlighted-col col-md-10">' +
                    (contact[0]['shortname'] ? contact[0]['shortname'] : contact[0]['name']) +
                '</div>' +
                '<div class="col-md-2 align-items-center">' +
                    '<div data-toggle="collapse" href="#contact'+contact[0]['id']+'" class="item-toggle collapsed d-inline-block pull-right"></div>' +
                    '<div class="action-list d-inline-block mx-3 pull-right" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" onClick="wtf(this)"></div>' +
                    '<div class="dropdown-menu">' +
                        '<div class="dropdown-item text-13 text-400 text-design-grey">Скрыть</div>' +
                        '<div class="dropdown-divider"></div>' +
                        '<div class="dropdown-item action-edit text-13 text-400 text-design-grey" data-id="'+contact[0]['id']+'">Редактировать</div>' +
                        '<div class="dropdown-divider"></div>' +
                        '<div class="dropdown-item action-delete text-13 text-400 text-design-grey" data-id="'+contact[0]['id']+'">Удалить</div>' +
                    '</div>' +
                '</div>' +
            '</div>' +
            '<hr class="m-0">' +
            '<div id="contact'+contact[0]['id']+'" class="collapse sidebar-submenu" data-id="2">' +
                '<div class="p-3">' +
                    '<div class="row">' +
                        '<div class="col-6 text-design-grey text-14">' +
                            'Телефон приемной' +
                        '</div>' +
                        '<div class="col-6 text-14">' +
                            (contact[0]['phone'] ? contact[0]['phone'] : '-') +
                        '</div>' +
                        '<div class="col-6 text-design-grey text-14">' +
                            'Адрес' +
                        '</div>' +
                        '<div class="col-6 text-14">' +
                            (contact[0]['address'] ? contact[0]['address'] : '-') +
                        '</div>' +
                        '<div class="col-6 text-design-grey text-14">' +
                            'Проезд' +
                        '</div>' +
                        '<div class="col-6 text-14">' +
                            (contact[0]['address_comment'] ? '<br>'+contact[0]['address_comment']+'<br><br>' : '-') +
                        '</div>' +
                        '<div class="col-6 text-design-grey text-14">' +
                            'Электронная почта' +
                        '</div>' +
                        '<div class="col-6 text-14">' +
                            (contact[0]['email'] ? contact[0]['email'] : '-') +
                        '</div>' +
                        '<div class="col-6 text-design-grey text-14">' +
                            'Сайт' +
                        '</div>' +
                        '<div class="col-6 text-14">' +
                            (contact[0]['www'] ? contact[0]['www'] : '-') +
                        '</div>' +
                    '</div>' +
                '</div>' +
                '<hr class="m-0">' +
            '</div>';
        });
        
        $('.block-main').html(contacts_str);
    }

    fetchContacts();
});

function wtf(el) {
    $(el).toggleClass('active')
}

</script>