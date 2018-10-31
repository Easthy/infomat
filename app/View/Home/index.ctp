<div class="sidebar white-content">
    <div class="p-3 sidebar-item-text d-flex justify-content-between align-items-center">
        Об учреждении <div data-toggle="collapse" href="#menu-expanded" class="item-toggle"></div>
    </div>
    <hr class="m-0">
    <div id="menu-expanded" class="collapse show">
        <div class="p-3 pl-4 sidebar-submenu active">
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
    <div class="p-3 sidebar-item-text">
        <a href="/contact" class="unstyled">Контакты</a>
    </div>
</div>

<div class="container-main">

	<div class="block-top white-content">
		<div class="p-3">
			<span class="block-top-title">Фото</span>	
		</div>
	</div>

	<div class="block-main white-content p-3">
        <div class="text-800 text-13 text-design-green">Редактировать фото</div>
        <hr>
        <div class="align-items-center row">
            <div class="col-sm-3 text-14 text-design-grey d-flex align-items-center">
                <input type="checkbox" class="checkbox-round" id="check_all"/>
                <label for="check_all" class="mr-3"></label>
                Выбрать все
            </div>
            <div class="col-sm-8"></div>
            <div class="col-sm-1">
                <img class="action-icon action-delete" src="/img/icons/delete.png">
            </div>
        </div>
		<div id="uploader-gallery" class="row">
            <div class="col-lg-2 py-2 d-flex justify-content-center">
                <div id="traditional-uploader"></div>
            </div>
        </div>
	</div>

</div>

<?php echo $this->element('fineuploader'); ?>

<script>
$(function() {
    $('body').on('click', '.checkbox-label', function() {
        var checkbox = $(this).closest('.overlay-visible').children('.checkbox-round');
        checkbox.prop("checked", !checkbox.prop("checked"));
    });

    $('#check_all').click(function() {
        $('.overlay-visible .checkbox-round').prop("checked", $('#check_all').prop('checked'));
    });

     $('.action-delete').click(function() {
        $('.overlay-visible .checkbox-round').each(function(index, el) {
            if($(el).prop("checked")) {
                var id = $(el).closest('.gallery-preview-item').attr('qq-file-id');
                traditionalUploader.deleteFile(id);
            }
        });
    });
});
    // For a traditional endpoint instance:
    // Some options to pass to the uploader are discussed on the next page
    var traditionalUploader = new qq.FineUploader({
        request: {
            endpoint: "/agency/uploadPhoto"
        },
        session: {
            endpoint: "/agency/getSession"
        },
        deleteFile: {
            enabled: true,
            endpoint: '/agency/deletePhoto',
            method: 'POST'
        },
        element: document.getElementById("traditional-uploader"),
        listElement: document.getElementById("uploader-gallery"),
        timeBetweenThumbs: 0,
        callbacks: {
            onDelete: function(id) {
                this.setDeleteFileParams({filename: this.getName(id)}, id);
            }
        }
    })

</script>