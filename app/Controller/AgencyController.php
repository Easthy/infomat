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

/**
 * Static content controller
 *
 * Override this controller by placing a copy in controllers directory of an application
 *
 * @package       app.Controller
 * @link https://book.cakephp.org/2.0/en/controllers/pages-controller.html
 */
class AgencyController extends AppController {

/**
 * This controller does not use a model
 *
 * @var array
 */
	public $uses = array();

/**
 * Displays a view
 *
 * @return CakeResponse|null
 * @throws ForbiddenException When a directory traversal attempt.
 * @throws NotFoundException When the view file could not be found
 *   or MissingViewException in debug mode.
 */
	public function uploadPhoto() {
		$this->layout = false;
		$this->autoRender = false; 

		if ( $this->request->is('ajax') ) {
			$this->loadModel('AgencyPhotoAlbum');
			$this->loadModel('AgencyPhoto');

			$album = $this->AgencyPhotoAlbum->get_data('get_album', ['agency_id' => AppModel::get_agency_id()],'extract');
			if (empty($album[0]['id'])){
				$album = $this->AgencyPhotoAlbum->get_data('create_album', ['agency_id' => AppModel::get_agency_id(),'name' => 'Фотоальбом','description'=>'Первый фотоальбом'],'extract');
			}

			$path = $this::uploadFile('img'.DS.'agency_'.(AppModel::get_agency_id()).DS.'album'.$album[0]['id'].DS);

	        $this->AgencyPhoto->get_data('create_photo', 
	        	['agency_id' => AppModel::get_agency_id(), 'path' => $path, 'photo_album_id' => $album[0]['id']]);
	 
	        $result['success']   = 'true';
	 
	        echo json_encode($result);
    	}
	}

	public function getSession() {
		$this->layout = false;
		$this->autoRender = false; 
		if ( $this->request->is('ajax') ) {
			$this->loadModel('AgencyPhotoAlbum');
			$this->loadModel('AgencyPhoto');

			$album = $this->AgencyPhotoAlbum->get_data('get_album', ['agency_id' => AppModel::get_agency_id()]);
			$album = $album[0][0];

	        $photos = $this->AgencyPhoto->get_data('get_photos', 
	        	['photo_album_id' => $album['id']]);

	 		$result = [];

	 		foreach ($photos as $i => $photo) {
	 			$result[$i]['thumbnailUrl'] = '/'.$photo[0]['path'];
	 			$result[$i]['uuid'] = pathinfo($photo[0]['path'], PATHINFO_BASENAME);
	 			$result[$i]['name'] = pathinfo($photo[0]['path'], PATHINFO_FILENAME);
	 		}

	        echo json_encode($result);
    	}
	}

	public function deletePhoto() {
		if ( $this->request->is('ajax') ) {
			$this->layout = false;
			$this->autoRender = false; 
			$this->loadModel('AgencyPhoto');

			$filename = $this->request->data['qquuid'];
			$photo = $this->AgencyPhoto->get_data('get_photo_by_filename', ['filename' => '%'.$filename.'%']);
			$this->AgencyPhoto->get_data('delete_photo_by_filename', ['filename' => '%'.$filename.'%']);
			$path = WWW_ROOT.$photo[0][0]['path'];
			unlink($path);
		}
	}
}
