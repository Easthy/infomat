<?=$this->Html->css('screensaver')?>
<link type="text/css" href="/css/service-basic.css" rel="stylesheet">

<div class="sidebar white-content">
    <div class="p-3 d-flex justify-content-between all-categories">
        <span class="text-14 text-600">Все заставки</span>
        <span class="text-12 text-700 text-design-green"></span> 
    </div>
    <?php if(!empty($screensavers)):?>
	    <?php foreach ($screensavers as $cat): ?>
	        <hr class="m-0">
	        <div class="p-3 d-flex justify-content-between show-screensaver" 
	        	data-image-id="<?= $cat['id'] ?>" 
	        	data-image-path="/<?= $cat['link_file'] ?>"
	        	data-image-name="<?= $cat['name'] ?>"
	        	data-image-active="<?= $cat['active'] ?>"
	        >
	            <span class="text-14 text-600"><?= $cat['name'] ?></span>
	            <span class="text-12 text-700 text-design-green"></span> 
	        </div>
	    <?php endforeach; ?>
	<?php endif;?>
</div>


<div class="container-main">

	<div class="block-top white-content">
		<div class="p-3 d-flex justify-content-between">
			<span class="block-top-title"><input id="screensaver-name" type="name" value="" /></span>
            <div class="btn-group form-toggle" data-toggle="modal" data-target="#activityModal">
                <div class="btn btn-dark-green">
                    <img src="/img/icons/plus_white.png">
                </div>
                <div class="btn btn-green" id="btn-create">
                    Создать заставку
                </div>
            </div>
		</div>
	</div>

	<div class="block-main white-content">
		<ul class="nav nav-tabs screensaver-type-change">
			<li class="nav-item">
    			<a class="nav-link active" href="#img" data-toggle="tab">Изображение</a>
  			</li>
  			<li class="nav-item">
  				<a class="nav-link" href="#video" data-toggle="tab">Видео</a>
  			</li>
  		</ul>

  		<div class="screensavers-controls">
            <ul class="menu">
                <li class="menu-item border" id="btn-upload">Сохранить для терминала</li>
                <li class="menu-item border" id="btn-activate">Активировать</li>
                <li class="menu-item border" id="btn-delete">Удалить</li>
            </ul>
  		</div>

  		<form id="screensaver-upload" action="/screensaver/upload" enctype="multipart/form-data" method="POST">
			<input id="screensaver-image" type="hidden" name="screensaver-image" />
			<input id="screensaver-name" type="hidden" name="screensaver-name" />
			<input id="screensaver-id" type="hidden" name="screensaver-id" />
			<input id="screensaver-active" type="hidden" name="screensaver-active" />
			
			<div class="tab-content">
				<div id="img" class="tab-pane container active">
					<?php echo $this->element('screensaver-basic')?>
				</div>
				<div id="video" class="tab-pane container fade">
					<ul class="menu">
            	        <li class="menu-item border input-wrapper">
            	            Выбрать видео
            	            <input type="file" accept="video/*" id="input-video-file" name="screensaver-video">
            	        </li>
            	    </ul>
            	    <div class="clears"></div>
					<!-- 16:9 aspect ratio -->
					<div class="embed-responsive embed-responsive-16by9">
						<video id="video-preview" no-controls="" autoplay="" loop="" data-setup="{}">
  							<source id="video-preview-source" src="" type="video/mp4">
						</video>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
$(function(){
	window.UrlExists = function (url)
	{
	    var http = new XMLHttpRequest();
	    http.open('HEAD', url, false);
	    http.send();
	    return http.status!=404;
	}

	$(document).on('click','.show-screensaver',function(){
		$(this).siblings().removeClass('active');
		$(this).addClass('active');
		$('#screensaver-name').val( $(this).data('image-name') );
		$('#btn-activate').removeClass('activated');
		if( $(this).data('image-active') == 1 ){
			$('#btn-activate').addClass('activated');
		}
		var file = $(this).data('image-path');
	    if( file && UrlExists(file) ){
			// Load sample image
			imageEditor.loadImageFromURL(file, 'SampleImage').then(sizeValue => {
		    	console.log(sizeValue);
		    	imageEditor.clearUndoStack();
			});
		}
	});

	$(document).on('click','#btn-create',function(){
		if($('[data-image-new]').length!=0){
			return;
		}
		var new_screensaver = '<hr class="m-0">\
	        <div class="p-3 d-flex justify-content-between show-screensaver" \
	        	data-image-id="" \
	        	data-image-path=""\
	        	data-image-name=""\
	        	data-image-active=""\
	        	data-image-new\
	        >\
	            <span class="text-14 text-600">Новая заставка</span>\
	            <span class="text-12 text-700 text-design-green"></span> \
	        </div>';
		$(new_screensaver).appendTo('.sidebar');
		$('[data-image-new]').click();
	});


	// Video
	$btnVideoFile = $('#input-video-file');
	$btnVideoFile.on('change',function(){
    	var file;
    	file = event.target.files[0];
    	if (!isValidFileType(file.name,'video')) {
    	    alert('Выбранный файл не может быть обработан');
    	    return;
    	}
		var $source = $('#video-preview-source');
		$source[0].src = URL.createObjectURL(this.files[0]);
  		$source.parent()[0].load();
	});
	//

	$('.screensaver-type-change a').on('click',function(){
		$('#video-preview')[0].pause();
		setTimeout(function(){
			if($('#video').is(':visible')===true){
				$('#video-preview')[0].play();
				console.log('play as visible is: ',$('#video').is(':visible'));
			}
		},500);
	});

	$('.show-screensaver:first').click();
	if($('.show-screensaver:first').length==0){
		$('#screensaver-name').val('Загрузите заставку');
	}
});
</script>
