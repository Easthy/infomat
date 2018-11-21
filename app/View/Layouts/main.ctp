<?php
/**
 * CakePHP(tm) : Rapid Development Framework (https://cakephp.org)
 * Copyright (c) Cake Software Foundation, Inc. (https://cakefoundation.org)
 *
 * Licensed under The MIT License
 * For full copyright and license information, please see the LICENSE.txt
 * Redistributions of files must retain the above copyright notice.
 *
 * @copyright     Copyright (c) Cake Software Foundation, Inc. (https://cakefoundation.org)
 * @link          https://cakephp.org CakePHP(tm) Project
 * @package       app.View.Layouts
 * @since         CakePHP(tm) v 0.10.0.1076
 * @license       https://opensource.org/licenses/mit-license.php MIT License
 */

$cakeDescription = __d('cake_dev', 'CakePHP: the rapid development php framework');
$cakeVersion = __d('cake_dev', 'CakePHP %s', Configure::version())
?>
<!DOCTYPE html>
<html>
<head>
	<?php echo $this->Html->charset(); ?>
	<title>
		<?php echo $this->fetch('title'); ?>
	</title>
	<!-- Insert this line above script imports  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link href="https://fonts.googleapis.com/css?family=Open+Sans|Roboto" rel="stylesheet">
	<link rel="stylesheet" href="/wickedpicker/stylesheets/wickedpicker.css">
	<link rel="stylesheet" href="/bootstrap-timepicker/css/bootstrap-timepicker.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker.min.css">
	<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">

	<script>if (typeof module === 'object') {window.module = module; module = undefined;}</script>

	<script src="https://api-maps.yandex.ru/2.1/?lang=en_RU" type="text/javascript"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/locale/ru.js"></script>

	<script   src="https://code.jquery.com/jquery-3.3.1.min.js"   integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="   crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

	<script type="text/javascript" src="/wickedpicker/src/wickedpicker.js"></script>
	<script type="text/javascript" src="/bootstrap-timepicker/js/bootstrap-timepicker.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.8.0/js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.8.0/locales/bootstrap-datepicker.ru.min.js"></script>
	<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
	
	<?php
		echo $this->Html->meta('icon');

		echo $this->Html->css(['main','addons']);

		echo $this->Html->script([
			'main'
		]);

		echo $this->fetch('meta');
		echo $this->fetch('css');
		echo $this->fetch('script');
	?>

	<!-- Insert this line after script imports -->
	<script>if (window.module) module = window.module;</script>
</head>
<body>
	<div id="container">
		<div id="header">
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<a class="navbar-brand  d-flex align-items-center" href="#">
					<img src="/img/icons/navbar_logo.png" width="30" height="30" class="d-inline-block align-top" alt="">
					<span class="px-2">ТЕРМИНАЛ</span>
				</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav">
						<?php if(!empty(Configure::read('Menu')[CakeSession::read('Auth.User.role')])):?>
							<?php foreach(Configure::read('Menu')[CakeSession::read('Auth.User.role')] as $key => $item):?>
								<li class="nav-item <?= in_array($this->request->controller, $item['active']) ? 'active' : '' ?>">
									<a 
										class="nav-link" 
										href="<?php echo $item['href']?>"
									>
										<?php echo $item['name']?>
									</a>
								</li>
							<?php endforeach;?>
						<?php endif;?>

						<?php if(!empty(CakeSession::read('Auth.User.role')&&CakeSession::read('Auth.User.role')==999)):?>
							<?php if(!empty($agencies)):?>
								<li class="nav-item dropdown">
									<a class="nav-link dropdown-toggle" href="javascript:void(0)" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										Войти как
									</a>
									<div class="dropdown-menu scrollable-menu" aria-labelledby="navbarDropdown">
										<?php foreach($agencies as $key => $ag):?>
											<a class="dropdown-item <?php echo $ag['id']==CakeSession::read('Auth.User.agency_id')?'active':'' ?>" href="/auth/enter_as?id=<?php echo $ag['id']?>"><?php echo $ag['shortname']?></a>
											<div class="dropdown-divider"></div>
										<?php endforeach;?>
									</div>
								</li>
							<?php endif;?>
						<?php endif;?>
					</ul>

					<ul class="navbar-nav ml-auto">
						<li class="nav-item d-flex align-items-center">
							<img src="/img/icons/icon_notification.png">
						</li>
						<li class="nav-item d-flex align-items-center">
							<img src="/img/icons/icon_settings.png">
						</li>
						<li class="nav-item d-flex align-items-center">
							<img src="/img/icons/icon_profile.png">
						</li>
						<li class="nav-item pull-right">
							<a class="nav-link" href="javascript:void(0)">
								<?php echo AppModel::get_username();?>
							</a>
						</li>
						<?php if($this->Session->check('Auth.User')):?>
							<li class="nav-item pull-right">
								<a class="nav-link" href="/users/logout">
									Выход
								</a>
							</li>
						<?php endif;?>
					</ul>
				</div>
			</nav>
		</div>

		<div id="content" class="<?=$this->request->controller?>-page <?=$this->request->action?>-action">

			<?php echo $this->Flash->render(); ?>

			
			<?php echo $this->fetch('content'); ?>						

		</div>

		<div id="footer">
		</div>
	</div>
</body>
</html>
