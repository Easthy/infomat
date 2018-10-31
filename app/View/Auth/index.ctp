<div class="container">
	<div class="login-form">
		<div class="main-div">
			<?php if(!$this->Session->check('Auth')):?>
				<div class="panel">
					<h2>Вход</h2>
				</div>
				<form id="Login" method="POST" action="/auth/login">
					<div class="form-group">
						<input type="username" class="form-control" id="inputEmail" name="username" placeholder="Имя пользователя">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" id="inputPassword" name="password" placeholder="Пароль">
					</div>
					<?php if(!empty($this->Session->read('Message'))):?>
						<div class="form-group alert alert-danger">
							<?php echo $this->Session->flash(); ?>
						</div>
					<?php endif;?>
					<button type="submit" class="btn btn-primary">Войти</button>
				</form>
			<?php else:?>
				<div class="panel">
					<h2>Вы уже вошли как <?php echo $this->Session->read('Auth.username')?></h2>
				</div>
				<form id="Login" method="GET" action="/auth/logout">
					<button type="submit" class="btn btn-primary">Выйти</button>
				</form>
			<?php endif;?>
		</div>
	</div>
</div>