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
class ContactController extends AppController {

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

	public function fetch() {
        if ( $this->request->is('ajax') ){
            $this->layout       = false;
            $this->autoRender   = false;

            $this->loadModel('Agency');

            $params = ['agency_id' => AppModel::get_agency_id()];

            $contacts = $this->Agency->get_data('get_contacts', $params);

            echo json_encode( $contacts );
        }
	}

    public function get() {
        if ( $this->request->is('ajax') ){
            $this->layout       = false;
            $this->autoRender   = false;
            
            $this->loadModel('Agency');

            $contact = $this->Agency->get_data('get_contact', ['id' => $this->request->query['id']]);

            echo json_encode( $contact );
        }
    }

    public function create() {
        $this->layout       = false;
        $this->autoRender   = false;
        
        if ( $this->request->is('ajax') ){
            $this->loadModel('Agency');

            $data = $this->request->data;

            $address = array_filter($data['address']);
            $address = implode(', ', $address);

            $this->Agency->get_data('create_contact', 
            [
                'headagency_id' => AppModel::get_agency_id(),
                'address' => $address,
                'address_comment' => $data['address_comment'],
                'fullname' => $data['fullname'],
                'shortname' => $data['shortname'],
                'www' => $data['www'],
                'phone' => $data['phone'],
                'email' => $data['email'],
            ]);
        }
    }

    public function update() {
        if ( $this->request->is('ajax') ){
            $this->layout       = false;
            $this->autoRender   = false;
            
            $this->loadModel('Agency');

            $data = $this->request->data;

            $address = array_filter($data['address']);
            $address = implode(', ', $address);

            $this->Agency->get_data('update_contact', 
            [
                'id' => $data['id'],
                'address' => $address,
                'address_comment' => $data['address_comment'],
                'fullname' => $data['fullname'],
                'shortname' => $data['shortname'],
                'www' => $data['www'],
                'phone' => $data['phone'],
                'email' => $data['email'],
            ]);
        }
    }

    public function delete() {
        if ( $this->request->is('ajax') ){
            $this->layout       = false;
            $this->autoRender   = false;
            
            $this->loadModel('Agency');

            $this->Agency->get_data('delete_contact', ['id' => $this->request->query['id']]);
        }
    }
}
