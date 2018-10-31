<div class="container">
	<div class="login-form">
		<div class="main-div">
			
			<form id="Login" method="POST" action="/users/login">
				<div class="form-group">
					<input type="username" class="form-control" id="inputEmail" name="data[User][username]" placeholder="Имя пользователя">
				</div>
				<div class="form-group">
					<input type="password" class="form-control" id="inputPassword" name="data[User][password]" placeholder="Пароль">
				</div>
				<?php if(!empty($this->Session->read('Message'))):?>
					<div class="form-group alert alert-danger">
						<?php echo $this->Session->flash(); ?>
						<?php echo $this->Flash->render('auth'); ?>
					</div>
				<?php endif;?>
				<button type="submit" class="btn btn-primary">Войти</button>
			</form>
		</div>
	</div>
</div>