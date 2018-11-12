<div class="sidebar white-content">
    <div class="p-3 d-flex justify-content-between active all-categories">
        <span class="text-14 text-600">Все мероприятия</span>
        <span class="text-12 text-700 text-design-green"></span> 
    </div>
    <?php foreach ($categories as $cat): ?>
        <hr class="m-0">
        <div class="p-3 d-flex justify-content-between" data-category-id="<?= $cat[0]['id'] ?>">
            <span class="text-14 text-600"><?= $cat[0]['name'] ?></span>
            <span class="text-12 text-700 text-design-green"></span> 
        </div>
    <?php endforeach; ?>
</div>

<div class="container-main">

	<div class="block-top white-content">
		<div class="p-3 d-flex justify-content-between">
			<span class="block-top-title">Все мероприятия</span>
            <div class="btn-group form-toggle" data-toggle="modal" data-target="#activityModal">
                <div class="btn btn-dark-green">
                    <img src="/img/icons/plus_white.png">
                </div>
                <div class="btn btn-green">
                    Создать мероприятие
                </div>
            </div>
		</div>
	</div>

	<div class="block-main white-content">
		
	</div>

</div>


<!-- Modal -->
<div class="modal" id="activityModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-id="0" data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <p>Создать мероприятие</p>
                <img src="/img/icons/modal_close.png" data-dismiss="modal" aria-label="Close" class="modal-close">
            </div>
            <div class="modal-body">
                <nav>
                    <div class="nav nav-tabs" id="nav-tab" role="tablist">
                        <a class="nav-item nav-link ml-3 active text-800 text-12" id="info-tab" data-toggle="tab" href="#nav-info" role="tab" aria-controls="nav-info" aria-selected="true">Основная информация</a>
                        <a class="nav-item nav-link mx-2 text-800 text-12" id="photo-tab" data-toggle="tab" href="#nav-photo" role="tab" aria-controls="nav-photo" aria-selected="false">фото мероприятия</a>
                        <a class="nav-item nav-link text-800 text-12" id="description-tab" data-toggle="tab" href="#nav-description" role="tab" aria-controls="nav-description" aria-selected="false">описание</a>
                    </div>
                </nav>
                <form>
                    <div class="tab-content pt-3" id="nav-tabContent">
                        <div class="tab-pane show active" id="nav-info" role="tabpanel" aria-labelledby="nav-info-tab">
                            <div class="form-group row">
                                <label  class="col-sm-2 col-form-label">Название</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="name">
                                </div>
                            </div>

                            <div class="form-group row">
                                <label  class="col-sm-2 col-form-label">Тип</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="periodicity_id">
                                        <?php foreach($periodicity as $period): ?>
                                            <option value="<?= $period[0]['id'] ?>"><?= $period[0]['name'] ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label  class="col-sm-2 col-form-label">Направление</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="category_id">
                                        <?php foreach($categories as $category): ?>
                                            <option value="<?= $category[0]['id'] ?>"><?= $category[0]['name'] ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label  class="col-sm-2 col-form-label">Дата и время</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control datepicker" name="start_date">
                                </div>
                                <div class="col-sm-2 single">
                                    <input type="text" class="form-control timepicker" name="start_time">
                                </div>
                                <div class="col-sm-2 single">
                                    <input type="text" class="form-control timepicker" name="end_time">
                                </div>
                            </div>

                            <div class="form-group row">
                                <label  class="col-sm-2 col-form-label">Окончание</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control datepicker" name="end_date">
                                </div>
                            </div>

                            <div class="form-group justify-content-between period py-3" style="display:none;">
                                <table style="width: 100%">
                                    <tbody>
                                    <tr>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="form-group row">
                                <label  class="col-sm-2 col-form-label">Адрес</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="address">
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="nav-photo" role="tabpanel" aria-labelledby="nav-photo-tab">
                            <div class="text-800 text-13 text-design-green">Добавить фото</div>
                            <hr>
                        </div>
                        <div class="tab-pane" id="nav-description" role="tabpanel" aria-labelledby="nav-description-tab">
                            <div class="text-800 text-13 text-design-green">Добавить описание</div>
                            <hr>
                            <div class="form-group row">
                                <div class="col-sm-12">
                                    <textarea class="form-control" rows="6" name="description"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="id">
                    <input type="hidden" name="path">
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
    $('.sidebar .p-3').click(function() {
        $('.sidebar .p-3').removeClass('active');
        $(this).addClass('active');

        $('.block-top .block-top-title').text($(this).find('.text-14').text());

        fetchActivities();
    });

    $('body').on('click', '.item-toggle', function() {
        $(this).closest('.row').toggleClass('active');
    });

    $('.modal select[name=periodicity_id]').change(function() {
        if($(this).val() == 1) {
            $('.modal .single').show();
            $('.modal .period').hide();
        } else {
            $('.modal .single').hide();
            $('.modal .period').show();
        }
    });

    function fetchActivities() {
        var category_id = $('.sidebar .p-3.active').data('category-id');

        if(category_id) {
            params = {category_id: category_id};
        } else {
            params = {}
        }

        $.ajax({
            url: "/long_life_activity/fetchActivity",
            dataType: "json",
            data: params,
            success: function(data) {
                drawActivities(data);
            }
        });
    }

    function prepareModal() {
        $( '.modal form' ).each(function(){
            this.reset();
        });

        $('.timepicker').timepicker('setTime', '');

        $('.nav-tabs a[href="#nav-info"]').tab('show');

        $('#uploader-gallery').remove();
        $('.modal #nav-photo').append('<div id="uploader-gallery" class="row px-3">' +
                                '<div class="uploader-container py-2">' +
                                    '<div id="traditional-uploader">' +
                                '</div></div></div>');
    }

    $('.form-toggle').click(function() {
        prepareModal();
        initUploader('');
        $('.modal form').attr('action', '/long_life_activity/create');
        
        $('.modal .single').show();
        $('.modal .period').hide();
    });

    $('body').on('click', '.action-edit', function() {
        prepareModal();
        initUploader($(this).data('id'));
        $('.modal form').attr('action', '/long_life_activity/update');
        $.ajax({
            url: "/long_life_activity/get",
            dataType: "json",
            data: {'id': $(this).data('id')},
            success: function(data) {
                if(data[0][0]['periodicity_id'] == 2) {
                    $('.modal .single').hide();
                    $('.modal .period').show();
                }

                fillForm(data);
            }
        });
        $('.modal').modal('toggle');
    });

    $('body').on('click', '.action-delete', function() {
        $.ajax({
            url: "/long_life_activity/delete",
            data: {'id': $(this).data('id')},
            success: function() {
                fetchActivities();
                updateCategories();
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
                fetchActivities();
                updateCategories();
            }
        });
    });

    function fillForm(data) {
        for (var field_name in data[0][0]){
            if (data[0][0][field_name] && $('form [name='+field_name+']:not(.datepicker)').length) {
                $('form [name='+field_name+']').val(data[0][0][field_name]);
            }
        }

        $("form [name=start_date]").datepicker("update", new Date(data[0][0]['start_date']));
        $("form [name=end_date]").datepicker("update", new Date(data[0][0]['end_date']));

        var schedule = JSON.parse(data[0][0]['schedule']);

        if(data[0][0]['periodicity_id'] == 1) {
            $('form [name=start_time]').timepicker('setTime', schedule[0]['start_time']);
            $('form [name=end_time]').timepicker('setTime', schedule[0]['end_time']);   
            
            $('.modal .single').show();
            $('.modal .period').hide();
        } else {
            schedule.forEach(function(day) {
                $('form [value='+day['date']+']').attr('checked',true);
                $('form [name="period_schedule_val['+day['date']+'][start]"]').timepicker('setTime', day['start_time']);
                $('form [name="period_schedule_val['+day['date']+'][end]"]').timepicker('setTime', day['end_time']);
            });
            
            $('.modal .single').hide();
            $('.modal .period').show();
        }
    }

    function drawActivities(activities) {
        activities_str = '';
        activities.forEach(function(activity) {
            var schedule = JSON.parse(activity[0]['schedule']);
            if(activity[0]['periodicity_id'] == 1) {
                var start_time = schedule[0]['start_time'] ? schedule[0]['start_time'] : ''; 
            } else {
                var start_time = '';
            }

            activities_str += '<div class="align-items-center p-3 row">' +
                '<div class="col-sm-2 pr-0 text-14 d-flex align-items-center">' +
                    '<input type="checkbox" class="checkbox-round" id="activitybox'+activity[0]['id']+'"/>' +
                    '<label for="activitybox'+activity[0]['id']+'" class="mr-2"></label>' +
                    '<div class="d-inline-block text-13 text-center">'+(new Date(activity[0]['start_date'])).toLocaleDateString("ru-RU")+'</span>' +
                    (start_time ? '<br>'+start_time : '') +
                    '</div>' +
                '</div>' +
                '<div class="col-sm-6 text-14 text-600 highlighted-col">' +
                    activity[0]['name'] +
                '</div>' +
                '<div class="col-sm-2 text-13 text-center">' +
                    activity[0]['cname'] +
                '</div>' +
                '<div class="col-sm-2 d-flex justify-content-end">' +
                    '<img class="action-icon action-delete mr-3" src="/img/icons/delete.png" data-id="'+activity[0]['id']+'">' +
                    '<img class="action-icon action-edit mr-4" src="/img/icons/edit.png" data-id="'+activity[0]['id']+'">' +
                    '<div data-toggle="collapse" href="#activity'+activity[0]['id']+'" class="item-toggle collapsed d-inline-block"></div>' +
                '</div>' +
                '</div>' +
                '<hr class="m-0">' +
                '<div id="activity'+activity[0]['id']+'" class="item-collapse collapse sidebar-submenu" data-id="'+activity[0]['id']+'">' +
                    '<div class="p-3">' +
                        '<div class="text-800 text-13 text-design-green">Адрес</div>' +
                        '<div class="text-13">'+activity[0]['address']+'</div>' +
                    '</div>' +
                    '<div class="p-3">' +
                        '<div class="text-800 text-13 text-design-green">Фото мероприятия</div>' +
                        (activity[0]['path'] ? '<img src="/'+activity[0]['path']+'" class="in-list-photo">' : '') +
                    '</div>' +
                    '<div class="p-3">' +
                        '<div class="text-800 text-13 text-design-green">Описание</div>' +
                        '<div class="text-13">'+activity[0]['description']+'</div>' +
                    '</div>' +
                    '<hr class="m-0">' +
                '</div>';
        });
        
        $('.block-main').html(activities_str);
    }

    function updateCategories() {
        $.ajax({
            url: "/long_life_activity/fetchCategories",
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

    function drawSchedule() {
        var days = [
            {label: 'ПН', name: 'mon'},
            {label: 'ВТ', name: 'tue'},
            {label: 'СР', name: 'wed'},
            {label: 'ЧТ', name: 'thu'},
            {label: 'ПТ', name: 'fri'},
            {label: 'СБ', name: 'sat'},
            {label: 'ВС', name: 'sun'},
        ];

        var schedule_str = '';

        days.forEach(function (day) {
            schedule_str += '<td style="width: 90px">' +
                '<div style="width: 90px" class="mx-auto">' +
                    '<div class="text-700 text-13 text-center">' +
                        '<input type="checkbox" class="checkbox-round" name="period_schedule[]" value="'+day['name']+'" id="'+day['name']+'"/>' +
                        '<label for="'+day['name']+'"></label>' +
                        day['label'] +
                    '</div>' +
                    '<div>' +
                        '<div class="form-control p-0 text-center">' +
                            '<input type="text" name="period_schedule_val['+day['name']+'][start]" class="timepicker">' +
                            '-' +
                            '<input type="text" name="period_schedule_val['+day['name']+'][end]" class="timepicker">' +
                        '</div>' +
                    '</div>' +
                '</div> ' +           
            '</td>';
        });

        $('.modal table tr').html(schedule_str);
    }

    function initUploader(id) {
        var traditionalUploader = new qq.FineUploader({
            request: {
                endpoint: "/long_life_activity/uploadPhoto"
            },
            deleteFile: {
                enabled: true,
                endpoint: "/long_life_activity/deletePhoto",
                params: {
                    id: id
                },
                method: 'POST'
            },
            session: {
                endpoint: "/long_life_activity/getSession",
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
                //         return false;
                //     }
                // }
            }
        })
    }

    updateCategories();
    drawSchedule();
    fetchActivities();

    $('.timepicker').timepicker({
        minuteStep: 5,
        maxHours: 24,
        showMeridian: false,
        template: 'dropdown',
        defaultTime: '00:00 AM',
        icons: {
            up: 'wickedpicker__controls__control-up',
            down: 'wickedpicker__controls__control-down'
        }
    });
    $('.datepicker').datepicker({
        language: 'ru'
    });

    $('.timepicker').click(function() {
        $('.timepicker').not(this).timepicker('hideWidget');
    });
});

</script>

<?php echo $this->element('fineuploader'); ?>