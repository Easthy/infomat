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
	        	data-image-path="<?= $cat['link_file'] ?>"
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
                <div class="btn btn-green">
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
	$(document).on('click','.show-screensaver',function(){
		$(this).siblings().removeClass('active');
		$(this).addClass('active');
		$('#screensaver-name').val( $(this).data('image-name') );
		$('#btn-activate').removeClass('activated');
		if( $(this).data('image-active') == 1 ){
			$('#btn-activate').addClass('activated');
		}
		var request = new XMLHttpRequest();
		request.open('GET', $(this).data('image-path'), true);
		request.onreadystatechange = function(){
		    if (request.readyState === 4){
		    	console.log('Image is missing');
		        if (request.status === 404) {  
		            return;
		        }  
		    }else{
				// Load sample image
				imageEditor.loadImageFromURL($(this).data('image-path'), 'SampleImage').then(sizeValue => {
				    console.log(sizeValue);
				    imageEditor.clearUndoStack();
				});
		    }
		};
	});

	$('.show-screensaver:first').click();
	if($('.show-screensaver:first').length==0){
		$('#screensaver-name').val('Загрузите заставку');
	}
})
</script>
