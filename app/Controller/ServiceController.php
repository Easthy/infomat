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
class ServiceController extends AppController {

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
		$this->loadModel('Service');
		$categories = $this->Service->get_data('get_service_categories');

		$this->set('categories', $categories);
	}

      public function fetchCategories() {
            if ( $this->request->is('ajax') ){
                  $this->layout       = false;
                  $this->autoRender   = false;
                  $this->loadModel('Service');
                  $categories = $this->Service->get_data('get_service_categories');
                  
                  echo json_encode($categories);
            }
      }

	public function fetchService() {
		if ( $this->request->is('ajax') ){
                  $this->layout       = false;
                  $this->autoRender   = false;
                  
                  $this->loadModel('Service');
                  $params = ['chargeable_type_id' => 0, 'category_id' => 0];

                  if($this->request->query && $this->request->query['category_id']) {
                  	$params['category_id'] = $this->request->query['category_id'];
                  }

                  if($this->request->query && $this->request->query['chargeable_type_id']) {
                        $params['chargeable_type_id'] = $this->request->query['chargeable_type_id'];
                  }

                  $services = $this->Service->get_data('filter_service', $params);
                  $service_ids = $this->Service->get_data('get_agency_services', ['agency_id' => 32],'format_active_service_ids');
                                    
                  if($this->request->query && $this->request->query['service_included']) {
                        $result_services = [];
                        if($this->request->query['service_included'] == 1) {
                              foreach ($services as $service) {
                                    if(!in_array($service[0]['id'], $service_ids)) {
                                          $result_services[] = $service;
                                    }
                              }
                              $services = $result_services;
                        } elseif ($this->request->query['service_included'] == 2) {
                              foreach ($services as $service) {
                                    if(in_array($service[0]['id'], $service_ids)) {
                                          $result_services[] = $service;
                                    }
                              }
                              $services = $result_services;
                        }
                  }

                  echo json_encode(['services' => $services, 'ids' => $service_ids]);
            }
	}

      public function enable() {
            if ( $this->request->is('ajax') ){
                  $this->layout       = false;
                  $this->autoRender   = false;
                  
                  $this->loadModel('Service');

                  if($this->request->data['status'] == 'enable') {
                        $this->Service->get_data('create_service_to_agency', ['agency_id' => 32, 'service_id' => $this->request->data['id']]);
                  } elseif($this->request->data['status'] == 'disable') {
                        $this->Service->get_data('delete_service_to_agency', ['agency_id' => 32, 'service_ids' => $this->request->data['id']]);
                  }
            }
      }

      public function enableMultiple() {
            if ( $this->request->is('ajax') ){
                  $this->layout       = false;
                  $this->autoRender   = false;
                  
                  $this->loadModel('Service');

                  if($this->request->data['status'] == 'enable') {
                        foreach (explode(',', $this->request->data['service_ids']) as $id) {
                              $this->Service->get_data('create_service_to_agency', ['agency_id' => 32, 'service_id' => $id]);
                        }
                  } elseif($this->request->data['status'] == 'disable') {
                        foreach (explode(',', $this->request->data['service_ids']) as $id) {
                              $this->Service->get_data('delete_service_to_agency', ['agency_id' => 32, 'service_ids' => $id]);
                        }
                  }
            }
      }
}
