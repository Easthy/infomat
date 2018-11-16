<?=$this->Html->css('screensaver')?>


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
       <?php echo $this->element('screensaver-basic')?>
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
		var new_screensaver = '<hr class="m-0">\
	        <div class="p-3 d-flex justify-content-between show-screensaver" \
	        	data-image-id="" \
	        	data-image-path=""\
	        	data-image-name=""\
	        	data-image-active=""\
	        >\
	            <span class="text-14 text-600">Новая заставка</span>\
	            <span class="text-12 text-700 text-design-green"></span> \
	        </div>';
		$('.sidebar').append(new_screensaver);
	});

	$('.show-screensaver:first').click();
	if($('.show-screensaver:first').length==0){
		$('#screensaver-name').val('Загрузите заставку');
	}
});
</script>
