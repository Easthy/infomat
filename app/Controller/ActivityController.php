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
class ActivityController extends AppController {

/**
 * This controller does not use a model
 *
 * @var array
 */
	public $uses = array('ActivityPhoto','Activity');

/**
 * Displays a view
 *
 * @return CakeResponse|null
 * @throws ForbiddenException When a directory traversal attempt.
 * @throws NotFoundException When the view file could not be found
 *   or MissingViewException in debug mode.
 */
      
      function __construct($request, $response) {
            parent::__construct($request, $response);
            $this->data_model = $this->Activity;
            $this->photo_model = $this->ActivityPhoto;
      }

	public function index() {
		$categories = $this->data_model->get_data('get_activity_categories', ['agency_id' => AppModel::get_agency_id()]);
            $periodicity = $this->data_model->get_data('get_activity_periodicity');

		$this->set('categories', $categories);
            $this->set('periodicity', $periodicity);
	}

      public function fetchCategories() {
            if ( $this->request->is('ajax') ){
                  $this->layout       = false;
                  $this->autoRender   = false;
                  $categories = $this->data_model->get_data('get_activity_categories', ['agency_id' => AppModel::get_agency_id()]);
                  
                  echo json_encode($categories);
            }
      }

	public function fetchActivity() {
            if ( $this->request->is('ajax') ){
                  $this->layout       = false;
                  $this->autoRender   = false;

                  $params = ['agency_id' => AppModel::get_agency_id()];

                  if($this->request->query && $this->request->query['category_id']) {
                        $params['category_id'] = $this->request->query['category_id'];
                        $activities = $this->data_model->get_data('get_activities_by_category', $params);
                  } else {
                        $activities = $this->data_model->get_data('get_activities', $params);
                  }

                  echo json_encode( $activities );
            }
	}

      public function get() {
            if ( $this->request->is('ajax') ){
                  $this->layout       = false;
                  $this->autoRender   = false;
                  
                  $activity = $this->data_model->get_data('get_activity', ['id' => $this->request->query['id']]);

                  echo json_encode( $activity );
            }
      }

      public function create() {
            $this->layout       = false;
            $this->autoRender   = false;
            
            if ( $this->request->is('ajax') ){
                  $data = $this->request->data;

                  $start_date = new \DateTime($data['start_date']);
                  $end_date = new \DateTime($data['end_date']);
                  $data['start_date'] = $start_date->format('Y-m-d');
                  $data['end_date'] = $end_date->format('Y-m-d');

                  $this->data_model->get_data('create_activity', 
                        [
                              'agency_id' => AppModel::get_agency_id(),
                              'type_id' => 1,
                              'start_date' => $data['start_date'],
                              'end_date' => $data['end_date'],
                              'category_id' => $data['category_id'],
                              'periodicity_id' => $data['periodicity_id'],
                              'name' => $data['name'],
                              'description' => $data['description'],
                              'address' => $data['address'],
                              'schedule' => $this->prepareSchedule($data)
                        ]);
            }

            if(preg_match('/^img\/tmp\//', $data['path'])) {
                  $last_id = $this->data_model->get_data('get_last_inserted');
                  $last_id = $last_id[0][0]['currval'];

                  $path = $this::moveFile('img/activity_'.$last_id.'/', $data['path']);

                  $this->photo_model->get_data('create_photo', ['activity_id' => $last_id, 'path' => $path]);
            }
      }

      public function update() {
            if ( $this->request->is('ajax') ){
                  $this->layout       = false;
                  $this->autoRender   = false;
                  
                  $data = $this->request->data;

                  if((preg_match('/^img\/tmp\//', $data['path'])) || empty($data['path'])) {
                        $photo = $this->photo_model->get_data('get_photo_by_activity', ['activity_id' => $data['id']]);

                        if(!empty($photo[0])) {
                              $this->photo_model->get_data('delete_photo', ['id' => $photo[0][0]['id']]);
                              unlink(WWW_ROOT.$photo[0][0]['path']);                       
                        }

                        if(preg_match('/^img\/tmp\//', $data['path'])) {
                              $path = $this::moveFile('img/activity_'.$data['id'].'/', $data['path']);
                              $this->photo_model->get_data('create_photo', ['activity_id' => $data['id'], 'path' => $path]);
                        } else {
                              $path = $data['path'];
                        }
                  }

                  $start_date = new \DateTime($data['start_date']);
                  $end_date = new \DateTime($data['end_date']);
                  $data['start_date'] = $start_date->format('Y-m-d');
                  $data['end_date'] = $end_date->format('Y-m-d');
                  
                  $this->data_model->get_data('update_activity', 
                        [
                              'start_date' => $data['start_date'],
                              'end_date' => $data['end_date'],
                              'category_id' => $data['category_id'],
                              'periodicity_id' => $data['periodicity_id'],
                              'name' => $data['name'],
                              'description' => $data['description'],
                              'address' => $data['address'],
                              'schedule' => $this->prepareSchedule($data),
                              'id' => $data['id']
                        ]);
            }
      }

      public function delete() {
            if ( $this->request->is('ajax') ){
                  $this->layout       = false;
                  $this->autoRender   = false;

                  $photo = $this->photo_model->get_data('get_photo_by_activity', ['activity_id' => $this->request->query['id']]);

                  $this->photo_model->get_data('delete_photo_by_activity', ['activity_id' => $this->request->query['id']]);
                  if(!empty($photo[0])) {
                        unlink(WWW_ROOT.$photo[0][0]['path']);                       
                  }
                  rmdir(WWW_ROOT.'img/activity_'.$this->request->query['id'].'/');
                  $this->data_model->get_data('delete_activity', ['id' => $this->request->query['id']]);
            }
      }

      public function deletePhoto() {
            if ( $this->request->is('ajax') ){
                  $this->layout       = false;
                  $this->autoRender   = false;


                  $this::deleteTmpFile($this->request->data['qquuid']);
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

      public function getSession() {
            if( $this->request->is('ajax') ) {
                  $this->layout       = false;
                  $this->autoRender   = false;

                  if($this->request->query['id']) {
                        $result = [];

                        $photos = $this->photo_model->get_data('get_photo_by_activity', ['activity_id' => $this->request->query['id']]);
                        foreach ($photos as $i => $photo) {
                              $result[$i]['thumbnailUrl'] = '/'.$photo[0]['path'];
                              $result[$i]['uuid'] = pathinfo($photo[0]['path'], PATHINFO_BASENAME);
                              $result[$i]['name'] = pathinfo($photo[0]['path'], PATHINFO_FILENAME);
                        }

                        echo json_encode($result);
                  } else {
                        echo '[]';
                  }
            }
      }

      protected function prepareSchedule($data) {
            $schedule = [];

            if($data['periodicity_id'] == 1) {
                  $start_date = new \DateTime(isset($data['start_date']) ? $data['start_date'] : '');

                  $schedule['date'] = isset($data['start_date']) ? $start_date->format('Y-m-d') : '';
                  $schedule['start_time'] = isset($data['start_time']) ? $data['start_time'] : '';
                  $schedule['end_time'] = isset($data['end_time']) ? $data['end_time'] : '';
                  
                  return json_encode([$schedule]);
            } else {
                  if(isset($data['period_schedule'])) {
                        foreach ($data['period_schedule'] as $day) {
                              $schedule[] = ['date' => $day, 'start_time' => $data['period_schedule_val'][$day]['start'], 'end_time' => $data['period_schedule_val'][$day]['end']];
                        }
                  }

                  return json_encode($schedule);
            }
      }
}
