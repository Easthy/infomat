<?php

App::uses('AppModel', 'Model');
App::uses('SimplePasswordHasher', 'Controller/Component/Auth');

class User extends AppModel {
    public $name = 'User';
    public $useTable='users';
    public $sql_dir = 'User';
	public function beforeSave($options = array()) {
	    if (isset($this->data[$this->alias]['password'])) {
	        $passwordHasher = new SimplePasswordHasher(array('hashType' => 'sha512'));
	        $this->data[$this->alias]['password'] = $passwordHasher->hash(
	            $this->data[$this->alias]['password'],
	            'sha256'
	        );
	    }
	    return true;
	}
}
