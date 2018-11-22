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
      public $uses = array('Screensavers','ScreenFile');

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
		$this->layout = false;
		$this->autoRender = false; 
		# Detect filetype
		$img 			= !empty($_POST['screensaver-image']) ? base64_decode( $_POST['screensaver-image'] ) : false;
		$video 			= !empty($_FILES['screensaver-video']) ? $_FILES['screensaver-video'] : false;

        # Saving file
		$random_string 	= CakeText::uuid();
		// Папка и полный путь к файлу для сохранения скринсейвера
		$file_type 		= !empty($img) ? 'img' : 'video';
		$extension 		= !empty($img) ? 'png' : pathinfo($_FILES['screensaver-video']['name'], PATHINFO_EXTENSION);
		$dir_to_store 	= $file_type.DS.'agency_'.(AppModel::get_agency_id()).DS.'screensavers';
		$file 			= $dir_to_store.DS.$random_string.'_'.(AppModel::get_agency_id()).'.'.$extension;
		//
		// Проверяем есть ли указанный путь и создаём если нет
		if ( !file_exists( WWW_ROOT.$dir_to_store ) ){
			mkdir( WWW_ROOT.$dir_to_store, 0777, true);
		}

		// Записываем данные в файл
		if ( !empty($img) ){
			file_put_contents(WWW_ROOT.$file,$img);	
		}
		if( !empty($video) && $video['size'] > 0 ){
			move_uploaded_file($video['tmp_name'], WWW_ROOT.$file);
		}
		
		$data = array(
			'active' 		=> !empty($this->request->data['screensaver-active'])? $this->request->data['screensaver-active'] : false,
			'name'   		=> !empty($this->request->data['screensaver-name'])? $this->request->data['screensaver-name'] : 'Заставка',
			'agency_id' 	=> AppModel::get_agency_id()
		);
		if(!empty($this->request->data['screensaver-id'])){
			$data['id'] = $this->request->data['screensaver-id'];
		}
		if ( !empty($data['active']) ){
			$this->Screensavers->query('UPDATE public.screen_saver SET active=false WHERE agency_id=:agency_id',array('agency_id'=>AppModel::get_agency_id()));
		}
		$screensavers = $this->Screensavers->save($data);

		$screensaver_id = $this->Screensavers->getLastInsertId() ? $this->Screensavers->getLastInsertId() : $this->request->data['screensaver-id'];
		
		// Update screen file only if file was uploaded
		if ($img || $video['size'] > 0){
			$screenfile = $this->ScreenFile->findByScreensaverId($screensaver_id);
			$data = array(
				'screensaver_id' => $screensaver_id,
				'link_file' => $file
			);
			if( !empty($screenfile['ScreenFile']['id']) ){
				$data['id'] = $screenfile['ScreenFile']['id'];
			}
			$this->ScreenFile->save($data);
		}

		$this->redirect('/screensaver');
	}

	public function delete($id){
		$this->layout = false;
		$this->autoRender = false; 

		$screensaver = $this->Screensavers->findById($id);

		if( empty($screensaver['Screensavers']['id']) ){
			$this->redirect('/screensaver');
			exit();
		}

		$this->Screensavers->query(
			'DELETE FROM public.screen_saver WHERE agency_id=:agency_id AND id=:id',
			array(
				'agency_id' => AppModel::get_agency_id(),
				'id' => $screensaver['Screensavers']['id']
			)
		);
		$screenfile = $this->ScreenFile->findByScreensaverId($screensaver['Screensavers']['id']);
		unlink(WWW_ROOT.$screenfile['ScreenFile']['link_file']);
		$this->ScreenFile->query(
			'DELETE FROM public.screen_file WHERE screensaver_id=:id',
			array(
				'id' => $screenfile['ScreenFile']['id']
			)
		);
		$this->redirect('/screensaver');
	}

	public function activate(){
		$this->layout = false;
		$this->autoRender = false; 
		if ( !empty($this->request->data['id']) ){
			$this->Screensavers->query('
				UPDATE public.screen_saver SET active=false WHERE agency_id=:agency_id',
				array(
					'agency_id'	=> AppModel::get_agency_id(),
				)
			);
			$this->Screensavers->id = $this->request->data['id'];
			$this->Screensavers->saveField('active',$this->request->data['active']);
		}
		echo json_encode(array('id'=>$this->request->data['id']));
	}
}
