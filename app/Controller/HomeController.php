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
class HomeController extends AppController {

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

	public function about() {
	}

	public function getDescription() {
		if ( $this->request->is('ajax') ){
			$this->layout       = false;
	        $this->autoRender   = false;

	        $this->loadModel('Agency');
	        $agency = $this->Agency->get_data('get_description', ['id' => 32]);

	        echo $agency[0][0]['description'];		
	    }
	}

	public function updateDescription() {
		if ( $this->request->is('ajax') ){
			$this->layout       = false;
	        $this->autoRender   = false;

	        $description = $this->request->data['description'];

			$this->loadModel('Agency');
	        $description = $this->Agency->get_data('update_description', ['description' => $description, 'id' => 32]);		
	    }
	}
}
