<?php
/**
 * Static content controller.
 *
 * This file will render views from views/pages/
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

App::uses('AppController', 'Controller');
App::uses('AppModel', 'Model');

/**
 * Static content controller
 *
 * Override this controller by placing a copy in controllers directory of an application
 *
 * @package       app.Controller
 * @link https://book.cakephp.org/2.0/en/controllers/pages-controller.html
 */
class ScreensaverController extends AppController {

/**
 * This controller does not use a model
 *
 * @var array
 */
      public $uses = array('Screensavers');

/**
 * Displays a view
 *
 * @return CakeResponse|null
 * @throws ForbiddenException When a directory traversal attempt.
 * @throws NotFoundException When the view file could not be found
 *   or MissingViewException in debug mode.
 */
	public function index() {
		$screensavers = $this->Screensavers->get_data(
                  'get_agency_screensavers',
                  ['agency_id'=>AppModel::get_agency_id()],
                  'extract'
            );
		$this->set('screensavers', $screensavers);
	}

	public function upload() {
        # Saving file
		$img = base64_decode( $_POST['base64Image'] );
		$random_string = CakeText::uuid();
			
		// Папка и полный путь к файлу для сохранения скринсейвера
		$dir_to_store = 'img/agency_'.(AppModel::get_agency_id()).DS.'screensavers';
		$file = $dir_to_store.DS.$random_string.'_'.(AppModel::get_agency_id()).'.png';
		// Проверяем есть ли указанный путь и создаём если нет
		if ( !file_exists( WWW_ROOT.$dir_to_store ) ){
			mkdir( $dir_to_store, 0777, true);
		}
		// Записываем данные в файл
		file_put_contents(WWW_ROOT.$file,$img);

		$data = array(
			'active' 		=> !empty($this->request->data['active'])? $this->request->data['active'] : false,
			'name'   		=> !empty($this->request->data['name'])? $this->request->data['name'] : 'Заставка',
			'agency_id' 	=> AppModel::get_agency_id()
		);
		if(!empty($this->request->data['id'])){
			$data['id'] = $this->request->data['id'];
		}
		$this->log($this->request->data['id']);
		
		if ( !empty($data['active']) ){
			$this->Screensavers->query('UPDATE public.screen_saver SET active=false WHERE agency_id=:agency_id',array('agency_id'=>AppModel::get_agency_id()));
		}
		$screensavers = $this->Screensavers->save($data);

		$this->loadModel('ScreenFile');
		$screensaver_id = $this->Screensavers->getLastInsertId() ? $this->Screensavers->getLastInsertId() : $this->request->data['id'];
		$screenfile = $this->ScreenFile->findByScreensaverId($screensaver_id);
		$data = array(
			'screensaver_id' => $screensaver_id,
			'link_file' => $file
		);
		if( !empty($screenfile['ScreenFile']['id']) ){
			$data['id'] = $screenfile['ScreenFile']['id'];
		}
		$this->ScreenFile->save($data);
		$this->redirect('/screensaver');
	}
}
