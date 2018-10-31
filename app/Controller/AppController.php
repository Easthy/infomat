<?php
/**
 * Application level Controller
 *
 * This file is application-wide controller file. You can put all
 * application-wide controller-related methods here.
 *
 * CakePHP(tm) : Rapid Development Framework (https://cakephp.org)
 * Copyright (c) Cake Software Foundation, Inc. (https://cakefoundation.org)
 *
 * Licensed under The MIT License
 * For full copyright and license information, please see the LICENSE.txt
 * Redistributions of files must retain the above copyright notice.
 *
 * @copyright     Copyright (c) Cake Software Foundation, Inc. (https://cakefoundation.org)
 * @link          https://cakephp.org CakePHP(tm) Project
 * @package       app.Controller
 * @since         CakePHP(tm) v 0.2.9
 * @license       https://opensource.org/licenses/mit-license.php MIT License
 */

App::uses('Controller', 'Controller');

/**
 * Application Controller
 *
 * Add your application-wide methods in the class below, your controllers
 * will inherit them.
 *
 * @package		app.Controller
 * @link		https://book.cakephp.org/2.0/en/controllers.html#the-app-controller
 */
class AppController extends Controller {
    public $components = array(
        'Flash',
        'Session',
        'Auth' => array(
            'loginRedirect' => array(
                'controller' => 'home',
                'action' => 'index'
            ),
            'logoutRedirect' => array(
                'controller' => 'users',
                'action' => 'login',
                'home'
            ),
            'authenticate' => array(
                'Form' => array(
                    'fields' => array(
    				    'password' => 'password',
    				    'username' => 'username'
    				),
    				'passwordHasher' => array(
                    	'className' => 'Simple',
                    	'hashType' => 'sha512'
                	)
                )
            ),
			'authError' => 'Войдите на сайт для просмотра запрошенной страницы.',
        	'loginError' => 'Не удалось выполнить вход, попробуйте ещё раз.'
        )
    );

	// only allow the login controllers only
	public function beforeFilter() {
	    $this->Auth->allow('login');
	    // App::uses('SimplePasswordHasher', 'Controller/Component/Auth');
		// $passwordHasher = new SimplePasswordHasher(array('hashType' => 'sha512'));
        // debug( $passwordHasher->hash('qwerty','sha512',true) );
	}

	public function isAuthorized($user) {
    	// Here is where we should verify the role and give access based on role 
    	return true;
	}

	public function beforeRender() {
	    parent::beforeRender();

	    $this->layout = 'main';
	}

	public static function deleteTmpFile($filename) {
		$tmp_dir = WWW_ROOT.'img/tmp/';
		$files = scandir($tmp_dir);
		$matches = preg_grep('/.*'.$filename.'.*/', $files);
		foreach ($matches as $match) {
			unlink($tmp_dir.$match);
		}
	}

	/*
    Загрузка файла на сервер
    */
    public static function uploadFile($dir = 'img/tmp/')
    {
		$upload_path = WWW_ROOT.$dir;

		if (!file_exists($upload_path)) {
            mkdir($upload_path, 0777, true);
        }

		$temp_file       = $_FILES['qqfile']['tmp_name'];
		$target_filename = $_POST['qquuid'];

		$extension = pathinfo($_FILES['qqfile']['name'], PATHINFO_EXTENSION);
		$target_filepath = $upload_path.$target_filename.'.'.$extension;
		move_uploaded_file($temp_file, $target_filepath);

		return $dir.$target_filename.'.'.$extension;
    }

    public static function moveFile($dir, $path) {
        if (!file_exists(WWW_ROOT.$dir)) {
            mkdir(WWW_ROOT.$dir, 0777, true);
        }

        $filename = pathinfo($path, PATHINFO_BASENAME);
        rename(WWW_ROOT.$path, WWW_ROOT.$dir.$filename);

        return $dir.$filename;
    }
}
