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
class ScheduleController extends AppController {

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

	public function get() {
		if ( $this->request->is('ajax') ){
			$this->layout       = false;
	        $this->autoRender   = false;
	        
			$this->loadModel('Agency');
	        $schedule = $this->Agency->get_data('get_schedule', ['id' => 32]);

	        echo $schedule[0][0]['timetable'];
		}
	}

	public function update() {
		if ( $this->request->is('ajax') ){
			$this->layout       = false;
	        $this->autoRender   = false;

	        $data = $this->request->data;
			$timetable = $this->processTimetable($data);

			$this->loadModel('Agency');
	        $this->Agency->get_data('update_schedule', ['id' => 32, 'timetable' => $timetable]);        
		}
	}

	protected function processTimetable($data) {
		$days = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
		$schedule = [];

		foreach ($days as $day) {
			if(isset($data[$day]) && $data[$day] == 'on') {
				$schedule[$day] = 't';
				$schedule[$day.'start'] = $data[$day.'start'];
				$schedule[$day.'end'] = $data[$day.'end'];
			} else {
				$schedule[$day] = 'f';
			}

			if(isset($data[$day.'b']) && $data[$day.'b'] == 'on') {
				$schedule[$day.'bs'] = $data[$day.'bs'];
				$schedule[$day.'be'] = $data[$day.'be'];
			}
		}

		return json_encode($schedule);
	}
}
