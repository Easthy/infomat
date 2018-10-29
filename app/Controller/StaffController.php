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
class StaffController extends AppController {

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
	public function index() {
		
	}

	public function fetchManagement() {
		if ( $this->request->is('ajax') ){
            $this->layout       = false;
            $this->autoRender   = false;
            
            $this->loadModel('AgencyManagement');

            $management = $this->AgencyManagement->get_data('get_management', ['agency_id' => 32]);

            echo json_encode( $management );
		}
	}

	public function getManagement() {
		if ( $this->request->is('ajax') ) {
                  $this->layout       = false;
                  $this->autoRender   = false;
                  
                  $this->loadModel('AgencyManagement');

                  $management = $this->AgencyManagement->get_data('get_management_entity', ['id' => $this->request->query['id']]);

                  echo json_encode( $management );
		}
	}

	public function create() {
		$this->layout       = false;
        $this->autoRender   = false;
		
		if ( $this->request->is('ajax') ){
            $this->loadModel('AgencyManagement');

            $data = $this->request->data;
            
            if(preg_match('/^img\/tmp\//', $data['path'])) {
            	$path = $this::moveFile('img/management_'.Configure::read('Terminal.CurrentAgencyId').'/', $data['path']);
            } else {
            	$path = $data['path'];
            }

            $this->AgencyManagement->get_data('create_management', 
            	[
            		'agency_id' => 32,
            		'firstname' => $data['firstname'],
            		'surname' => $data['surname'],
            		'fathername' => $data['fathername'],
            		'post' => $data['post'],
            		'phone' => $data['phone'],
            		'path' => $path
            	]);
		}
	}

	public function update() {
		if ( $this->request->is('ajax') ){
            $this->layout       = false;
            $this->autoRender   = false;
            
            $this->loadModel('AgencyManagement');

            $data = $this->request->data;

            if((preg_match('/^img\/tmp\//', $data['path'])) || empty($data['path'])) {
                  $management = $this->AgencyManagement->get_data('get_management_entity', ['id' => $data['id']]);
                  if(!empty($management[0][0]['path'])) {
                        $path = WWW_ROOT.$management[0][0]['path'];
                        unlink($path);
                  }


                  if(preg_match('/^img\/tmp\//', $data['path'])) {
                        $path = $this::moveFile('img/management_'.Configure::read('Terminal.CurrentAgencyId').'/', $data['path']);
                  } else {
                        $path = $data['path'];
                  }
            }

            $this->AgencyManagement->get_data('update_management', 
            	[
            		'agency_id' => 32,
            		'id' => $data['id'],
            		'firstname' => $data['firstname'],
            		'surname' => $data['surname'],
            		'fathername' => $data['fathername'],
            		'post' => $data['post'],
            		'phone' => $data['phone'],
            		'path' => $path
            	]);
		}
	}

	public function delete() {
		if ( $this->request->is('ajax') ){
                  $this->layout       = false;
                  $this->autoRender   = false;
                  
                  $this->loadModel('AgencyManagement');

                  $management = $this->AgencyManagement->get_data('get_management_entity', ['id' => $this->request->query['id']]);
                  $this->AgencyManagement->get_data('delete_management', ['id' => $this->request->query['id'], 'agency_id' => 32]);
                  unlink(WWW_ROOT.$management[0][0]['path']);
		}
	}

	public function uploadPhoto() {
		if ( $this->request->is('ajax') ){
                  $this->layout       = false;
                  $this->autoRender   = false;

                  $result['success']   = 'true';
                  $result['path'] = $this::uploadFile('img/tmp/');

                  echo json_encode($result);
		}
	}

      public function deletePhoto() {
            if ( $this->request->is('ajax') ){
                  $this->layout       = false;
                  $this->autoRender   = false;
                  
                  $this::deleteTmpFile($this->request->data['qquuid']);
            }
      }

      public function getSession() {
            if( $this->request->is('ajax') ) {
                  $this->layout       = false;
                  $this->autoRender   = false;

                  if($this->request->query['id']) {
                        $this->loadModel('AgencyManagement');
                        $result = [];

                        $management = $this->AgencyManagement->get_data('get_management_entity', ['id' => $this->request->query['id']]);

                        if($management[0][0]['path']) {
                              $result[0]['thumbnailUrl'] = '/'.$management[0][0]['path'];
                              $result[0]['uuid'] = pathinfo($management[0][0]['path'], PATHINFO_BASENAME);
                              $result[0]['name'] = pathinfo($management[0][0]['path'], PATHINFO_FILENAME);

                              echo json_encode($result);
                        } else {
                              echo '[]';
                        }
                  } else {
                        echo '[]';
                  }
            }
      }
}
