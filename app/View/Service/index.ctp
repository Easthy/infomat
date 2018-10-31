<div class="sidebar white-content">
    <div class="p-3 d-flex justify-content-between active all-categories" data-category-id="0">
        <span class="text-14 text-600">Все услуги</span>
        <span class="text-12 text-700 text-design-green"></span> 
    </div>
    <?php foreach ($categories as $cat): ?>
        <hr class="m-0">
        <div class="p-3 d-flex justify-content-between" data-category-id="<?= $cat[0]['id'] ?>">
            <span class="text-14 text-600"><?= $cat[0]['text'] ?></span>
            <span class="text-12 text-700 text-design-green"></span> 
        </div>
    <?php endforeach; ?>
</div>

<div class="container-main">

	<div class="block-top white-content">
		<div class="p-3 d-flex justify-content-between">
			<span class="block-top-title">Все услуги</span>
            <div>
                <div class="dropdown d-inline-block">
                    <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="enabledMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Подключение
                    </button>
                    <div class="dropdown-menu enabled-type" aria-labelledby="enabledMenuButton">
                        <div class="dropdown-item active" data-value="0">Все</div>
                        <div class="dropdown-item" data-value="2">Подкючена</div>
                        <div class="dropdown-item" data-value="1">Не подключена</div>
                    </div>
                </div>
                <div class="dropdown d-inline-block">
                    <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="chargeableMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Тип оплаты
                    </button>
                    <div class="dropdown-menu chargeable-type" aria-labelledby="chargeableMenuButton">
                        <div class="dropdown-item active" data-value="0">Все</div>
                        <div class="dropdown-item" data-value="1">Платные</div>
                        <div class="dropdown-item" data-value="3">Бесплатные</div>
                    </div>
                </div>
            </div>
		</div>
        <hr class="m-0">
        <div class="align-items-center p-3 row">
            <div class="col-sm-1">
                <input type="checkbox" class="checkbox-round" id="check_all"/>
                <label for="check_all"></label>
            </div>
            <div class="col-sm-6 text-14 text-design-grey">
                Выбрать все
            </div>
            <div class="col-sm-3 text-14 text-design-grey text-right">
                Подключить
            </div>
            <div class="col-sm-1">
                <input type="checkbox" data-off="OFF" data-on="ON" data-toggle="toggle" data-height="28" data-size="mini" data-style="design" data-onstyle="design" data-offstyle="design" id="enable_all">
            </div>
            <div class="col-sm-1">
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
                <form>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control">
                        </div>
                    </div>
                    
                    <div class="text-800 text-13 text-design-green">Адрес</div>
                    <hr>

                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control">
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-sm-2"></div>
                        <div class="col-sm-10 row">
                            <div class="form-group col-sm-3">
                                <label>Example file input</label>
                                <input type="text" class="form-control" >
                            </div>
                            <div class="form-group col-sm-3">
                                <label>Example file input</label>
                                <input type="text" class="form-control" >
                            </div>
                            <div class="form-group col-sm-3">
                                <label>Example file input</label>
                                <input type="text" class="form-control" >
                            </div>
                            <div class="form-group col-sm-3">
                                <label>Example file input</label>
                                <input type="text" class="form-control" >
                            </div>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Password</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" rows="3"></textarea>
                        </div>
                    </div>

                    <div class="text-800 text-13 text-design-green">Контакты</div>
                    <hr>

                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control">
                        </div>
                    </div>
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
    var global_change = false;

    $('.sidebar .p-3').click(function() {
        $('.sidebar .p-3').removeClass('active');
        $(this).addClass('active');

        $('.block-top .block-top-title').text($(this).find('.text-14').text());

        fetchServices();
        // if($(this).data('category-id')) {
        //     fetchServices({category_id: $(this).data('category-id')});
        // } else {
        //     fetchServices();
        // }
    });

    $('body').on('click', '.item-toggle', function() {
        $(this).closest('.row').toggleClass('active');
    });

    $('#check_all').click(function() {
        $('.service-check').prop("checked", $('#check_all').prop('checked'));
    });

    $('#enable_all').on('change', function() {
        if($('.service-check').filter(':checked').length > 0) {
            var checked = $(this).is(':checked');
            var ids = [];
            global_change = true;
            $('.service-check:checked').each(function(index, element) {
                var id = $(element).data('id');
                var element_checked = $('.enable-service[data-id='+id+']').prop('checked');

                if(checked && !element_checked) {
                    $('.enable-service[data-id='+id+']').bootstrapToggle('on');
                    ids.push(id);
                } else if(!checked && element_checked) {
                    $('.enable-service[data-id='+id+']').bootstrapToggle('off');
                    ids.push(id);
                }
            });
            global_change = false;

            $.ajax({
                url: "/service/enableMultiple",
                dataType: "json",
                method: 'post',
                data: {
                    service_ids: ids.join(','),
                    status: checked ? 'enable' : 'disable'
                },
                success: function(data) {
                }
            });
        }
    });

    $('.chargeable-type .dropdown-item').click(function() {
        $('.chargeable-type .dropdown-item').removeClass('active');
        $(this).addClass('active');
        fetchServices();
    });

    $('.enabled-type .dropdown-item').click(function() {
        $('.enabled-type .dropdown-item').removeClass('active');
        $(this).addClass('active');
        fetchServices();
    });

    function fetchServices() {
        var cat = $('.sidebar .p-3.active').data('category-id');
        var chargeable_type_id = $('.chargeable-type .active').data('value');
        var service_included = $('.enabled-type .active').data('value');

        $.ajax({
            url: "/service/fetchService",
            dataType: "json",
            data: {
                category_id: cat,
                chargeable_type_id: chargeable_type_id,
                service_included: service_included
            },
            success: function(data) {
                drawServices(data);
            }
        });
    }

    function drawServices(data) {
        services_str = '';
        var services = data['services'];
        var ids = data['ids'];
        services.forEach(function(service) {
            if(service[0]['price']) {
                var service_price = service[0]['price'] + ' руб';
            } else if(service[0]['price_hour']) {
                var service_price = service[0]['price_hour'] + ' руб/ч';
            } else {
                var service_price = '<span class="text-design-grey">Бесплатно</span>';
            }

            services_str += '<div class="align-items-center p-3 row">' +
                '<div class="col-sm-1">' +
                    '<input type="checkbox" class="checkbox-round service-check" id="servicebox'+service[0]['id']+'" data-id="'+service[0]['id']+'"/>' +
                    '<label for="servicebox'+service[0]['id']+'"></label>' + 
                '</div>' +
                '<div class="col-sm-1 text-14 text-600 highlighted-col">' +
                    (service[0]['code'] ? service[0]['code'] : '') +
                '</div>' +
                '<div class="col-sm-7 text-14 text-600 highlighted-col">' +
                    service[0]['name'] +
                '</div>' +
                '<div class="col-sm-1 text-14">' +
                    service_price +
                '</div>' +
                '<div class="col-sm-1">' +
                    '<input type="checkbox" data-off="OFF" data-on="ON" data-toggle="toggle" data-height="28" data-size="mini" data-style="design" data-onstyle="design" data-offstyle="design" id="enable_all" class="enable-service" data-id="'+service[0]['id']+'" '+(ids.includes(service[0]['id']) ? 'checked' : '')+'>' +
                '</div>' +
                '<div class="col-sm-1">' +
                    '<div data-toggle="collapse" href="#service'+service[0]['id']+'" class="item-toggle collapsed pull-right" data-id="'+service[0]['id']+'"></div>' +
                '</div>' +
                '</div>' +
                '<hr class="m-0">' +
                '<div id="service'+service[0]['id']+'" class="collapse sidebar-submenu" data-id="'+service[0]['id']+'">' +
                    '<div class="p-3">' +
                        '<div class="text-800 text-13 text-design-green">Основная информация</div>' +
                        '<div class="row">' +
                            '<div class="col-6 text-13 text-design-grey">' +
                                'Стоимость:' + 
                            '</div>' +
                            '<div class="col-6 text-13">' +
                                (service[0]['price'] ? service[0]['price']+' руб.' : service[0]['price_hour'] ? service[0]['price_hour']+' руб. в час' : '-') +
                            '</div>' +
                            '<div class="col-6 text-13 text-design-grey">' +
                                'Форма предоставления:' +
                            '</div>' +
                            '<div class="col-6 text-13">' +
                                service[0]['text'] +
                            '</div>' +
                            '<div class="col-6 text-13 text-design-grey">' +
                                'Норма времени выполнения услуги:' +
                            '</div>' +
                            '<div class="col-6 text-13">' +
                                (service[0]['time'] ? service[0]['time']+' мин' : '-') +
                            '</div>' +
                            '<div class="col-6 text-13 text-design-grey">' +
                                'Стоимость услуги:' +
                            '</div>' +
                            '<div class="col-6 text-13">' +
                                (service[0]['price'] ? service[0]['price']+' руб.' : service[0]['price_hour'] ? service[0]['price_hour']+' руб.' : '-') +
                            '</div>' +
                            '<div class="col-6 text-13 text-design-grey">' +
                                'Вес услуги:' +
                            '</div>' +
                            '<div class="col-6 text-13">' +
                                '-' +
                            '</div>' +
                        '</div>' + 
                    '</div>' +
                    '<div class="p-3">' +
                        '<div class="text-800 text-13 text-design-green">Условия предоставления</div>' +
                        '<div class="row">' +
                            '<div class="col-6 text-13 text-design-grey">' +
                                'Бесплатно:' + 
                            '</div>' +
                            '<div class="col-6 text-13">' +
                                '-' +
                            '</div>' +
                            '<div class="col-6 text-13 text-design-grey">' +
                                'Платно:' +
                            '</div>' +
                            '<div class="col-6 text-13">' +
                                (service[0]['price'] ? service[0]['price']+' руб.' : service[0]['price_hour'] ? service[0]['price_hour']+' руб.' : '-') +
                            '</div>' +
                        '</div>' + 
                    '</div>' +
                    '<div class="p-3">' +
                        '<div class="text-800 text-13 text-design-green">Ресурсы учреждения</div>' +
                        '<div class="row">' +
                            '<div class="col-6 text-13 text-design-grey">' +
                                'Материальные:' + 
                            '</div>' +
                            '<div class="col-6 text-13">' +
                                (service[0]['agency_resources'] ? formatTextData(service[0]['agency_resources']) : '-') +
                            '</div>' +
                        '</div>' + 
                    '</div>' +
                    '<div class="p-3">' +
                        '<div class="text-800 text-13 text-design-green">Ресурсы клиента</div>' +
                        '<div class="row">' +
                            '<div class="col-6 text-13 text-design-grey">' +
                                'Финансовые:' +
                            '</div>' +
                            '<div class="col-6 text-13">' +
                                (service[0]['price'] ? service[0]['price']+' руб.' : service[0]['price_hour'] ? service[0]['price_hour']+' руб.' : '-') +
                            '</div>' +
                            '<div class="col-6 text-13 text-design-grey">' +
                                'Материальные:' + 
                            '</div>' +
                            '<div class="col-6 text-13">' +
                                (service[0]['client_resources'] ? formatTextData(service[0]['client_resources']) : '-') +
                            '</div>' +
                        '</div>' + 
                    '</div>' +
                    '<div class="p-3">' +
                        '<div class="text-800 text-13 text-design-green">Регламент</div>' +
                            '<div class="text-13 text-design-grey">' +
                                'Порядок выполнения:' +
                            '</div>' +
                            '<div class="text-13">' +
                                (service[0]['description'] ? formatTextData(service[0]['description'], true) : '-') +
                            '</div>' +
                            '<div class="text-13 text-design-grey">' +
                                'Результат:' +
                            '</div>' +
                            '<div class="text-13">' +
                                (service[0]['result'] ? formatTextData(service[0]['result'], true) : '-') +
                            '</div>' +
                    '</div>' +
                    '<hr class="m-0">' +
                '</div>';
        });

        $('.block-main').html(services_str);
        $('.enable-service').bootstrapToggle();
        $('.enable-service').change(function() {
            if(!global_change) {
                $.ajax({
                    url: "/service/enable",
                    dataType: "json",
                    method: 'post',
                    data: {
                        id: $(this).data('id'),
                        status: $(this).is(':checked') ? 'enable' : 'disable'
                    },
                    success: function(data) {
                    }
                });
            }
        })
    }

    function updateCategories() {
        $.ajax({
            url: "/service/fetchCategories",
            success: function(data) {
                data = JSON.parse(data);
                var sum = 0;
                data.forEach(function (cat) {
                    var counter = cat[0]['counter'] ? cat[0]['counter'] : 0;
                    sum += counter;
                    $('div [data-category-id='+cat[0]['id']+'] .text-12').html(counter);
                });
                $('.all-categories .text-12').html(sum);
            }
        });
    }

    function formatTextData(data, ordered) {
        data = JSON.parse(data);
        var result = ordered ? '<ol>' : '<ul class="list-unstyled">';
        data.forEach(function(el){
            el = el.replace(';', '');
            result += '<li>'+el+'</li>';
        });
        result += ordered ? '</ol>' : '</ul>';
        return result;
    }

    updateCategories();
    fetchServices();
});
</script>