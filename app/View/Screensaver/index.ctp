<?=$this->Html->css('screensaver')?>


<div class="sidebar white-content">
    <div class="p-3 d-flex justify-content-between active all-categories">
        <span class="text-14 text-600">Все заставки</span>
        <span class="text-12 text-700 text-design-green"></span> 
    </div>
    <?php if(!empty($screensavers)):?>
	    <?php foreach ($screensavers as $cat): ?>
	        <hr class="m-0">
	        <div class="p-3 d-flex justify-content-between" data-category-id="<?= $cat[0]['id'] ?>">
	            <span class="text-14 text-600"><?= $cat[0]['name'] ?></span>
	            <span class="text-12 text-700 text-design-green"></span> 
	        </div>
	    <?php endforeach; ?>
	<?php endif;?>
</div>


<div class="container-main">

	<div class="block-top white-content">
		<div class="p-3 d-flex justify-content-between">
			<span class="block-top-title"></span>
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
