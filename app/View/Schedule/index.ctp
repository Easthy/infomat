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
        <div class="p-3 pl-4 sidebar-submenu active">
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
    <div class="p-3 sidebar-item-text">
        <a href="/contact" class="unstyled">Контакты</a>
    </div>
</div>

<div class="container-main">

	<div class="block-top white-content">
		<div class="p-3">
			<span class="block-top-title">Режим работы</span>	
		</div>
	</div>

	<div class="block-main white-content p-3">
        <form>
        </form>
	</div>

</div>

<script type="text/javascript">
$(function() {
    var days = [
            {label: 'Понедельник', name: 'mon'},
            {label: 'Вторник', name: 'tue'},
            {label: 'Среда', name: 'wed'},
            {label: 'Четверг', name: 'thu'},
            {label: 'Пятница', name: 'fri'},
            {label: 'Суббота', name: 'sat'},
            {label: 'Воскресенье', name: 'sun'},
        ];

    function get() {
        $.ajax({
            url: "/schedule/get",
            dataType: "json",
            success: function(data) {
                fillForm(data);
            }
        });
    }

    function update() {
        $.ajax({
            method: 'post',
            url: "/schedule/update",
            data: $('form').serialize(),
            success: function() {
            }
        });
    }

    $('body').on('click', '.btn-default', get);
    $('body').on('click', '.btn-success', update);

    function drawSchedule() {
        var schedule_str = '';

        days.forEach(function (day) {
            schedule_str += '<div class="row">' +
                '<div class="col-6">' +
                    '<div class="row align-items-center">' +
                        '<div class="col-md-4 schedule-text pr-0 mr-0">' +
                            '<input type="checkbox" class="checkbox-round" name="'+day['name']+'" id="'+day['name']+'"/>' +
                            '<label for="'+day['name']+'" class="mr-2"></label>' +
                            day['label'] +
                        '</div>' +
                        '<div class="col-md-4 schedule-text pr-0 mr-0">' +
                            'с' +
                            '<input type="text" name="'+day['name']+'start" class="timepicker ml-2"/>' +
                        '</div>' +
                        '<div class="col-md-4 schedule-text p-0 m-0">' +
                            'до' +
                            '<input type="text" name="'+day['name']+'end" class="timepicker ml-2"/>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
                '<div class="col-6">' +
                    '<div class="row align-items-center">' +
                        '<div class="col-md-4 schedule-text">' +
                            '<input type="checkbox" class="checkbox-round" name="'+day['name']+'b" id="'+day['name']+'b"/>' +
                            '<label for="'+day['name']+'b" class="mr-2"></label>' +
                            'Перерыв' +
                        '</div>' +
                        '<div class="col-md-4 schedule-text p-0 m-0">' +
                            'с' +
                            '<input type="text" name="'+day['name']+'bs" class="timepicker ml-2"/>' +
                        '</div>' +
                        '<div class="col-md-4 schedule-text p-0 m-0">' +
                            'до' +
                            '<input type="text" name="'+day['name']+'be" class="timepicker ml-2"/>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
            '</div>' +
            '<hr>';
        });
        
        schedule_str += '<a class="btn btn-default">Отменить</a>' +
            '<a class="btn btn-success">Сохранить</a>';

        $('.block-main form').html(schedule_str);
    }

    function fillForm(schedule) {
        days.forEach(function (day) {
            if(schedule[day['name']] == 't') {
                $('form [name='+day['name']+']').prop('checked',true);
            } else {
                $('form [name='+day['name']+']').prop('checked',false);
            }

            $('form [name='+day['name']+'start]').timepicker('setTime', schedule[day['name']+'start']);
            $('form [name='+day['name']+'end]').timepicker('setTime', schedule[day['name']+'end']);

            if(schedule[day['name']+'bs'] || schedule[day['name']+'be']) {
                $('form [name='+day['name']+'b]').prop('checked',true);
            } else {
                $('form [name='+day['name']+'b]').prop('checked',false);
            }

            $('form [name='+day['name']+'bs]').timepicker('setTime', schedule[day['name']+'bs']);
            $('form [name='+day['name']+'be]').timepicker('setTime', schedule[day['name']+'be']);
        });
    }

    drawSchedule();
    $('.timepicker').timepicker({
        minuteStep: 5,
        maxHours: 24,
        showMeridian: false,
        template: 'dropdown',
        defaultTime: false,
        icons: {
            up: 'wickedpicker__controls__control-up',
            down: 'wickedpicker__controls__control-down'
        }
    });

    get();
});
</script>