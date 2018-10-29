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
		<div class="p-3 pl-4 sidebar-submenu active">
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

	<div class="block-main single white-content p-3">
        <p class="block-top-title">Описание</p>
        <p class="subtitle-green">Текст описания</p>
        <form action="/home/update" method="post">
        	<textarea id="description" name="description">
    		</textarea>
    	<hr>
		<a class="btn btn-default">Отменить</a>
	    <a class="btn btn-success">Сохранить</a>
	    </form>
	</div>
</div>


<script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script>
<script>
$(function() {
	var mce = tinymce.init({ 
		selector:'textarea'
	});

    function get() {
        $.ajax({
            url: "/home/getDescription",
            success: function(data) {
            	$('textarea').html(data);
            	tinymce.get('description').load()
            }
        });
    }

    function update() {
        $.ajax({
            method: 'post',
            url: "/home/updateDescription",
            data: $('form').serialize(),
            success: function() {
            }
        });
    }

    $('body').on('click', '.btn-default', get);
    $('body').on('click', '.btn-success', function() {
    	tinymce.get('description').save();
    	update();
    });

    get();
});
</script>