<?php
/**
 * AppShell file
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
 * @since         CakePHP(tm) v 2.0
 * @license       https://opensource.org/licenses/mit-license.php MIT License
 */

App::uses('Shell', 'Console');

/**
 * Application Shell
 *
 * Add your application-wide methods in the class below, your shells
 * will inherit them.
 *
 * @package       app.Console.Command
 */
class AppShell extends Shell {

	public function create_users(){
		$this->loadModel('User');
		$this->loadModel('Agency');
		$agencies = $this->Agency->query('SELECT id, fullname, shortname FROM public.agency;');
		$agencies = HASH::extract($agencies,'{n}.{n}');
		$length = 6;
		foreach ($agencies as $ag) {
			$password = substr(str_shuffle(str_repeat($x='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil($length/strlen($x)) )),1,$length);
			$username = 'infomat_'.$ag['id'];
			$agency = $ag['shortname'];

			$this->User->save(
				array(
					'username' => $username,
					'password' => $password,
					'agency_id'=> $ag['id'],
					'role'	   => 0,
					'created'  => date('d.m.Y H:i:s')
				)
			);
			$user_id = $this->User->getLastInsertID();
			$this->User->clear();

			$data = array('user_id'=>$user_id,'agency_id'=> $ag['id'],'agency'=>$agency,'username'=>$username,'password'=>$password);
			$data = join('	',$data);

			$data = $data.PHP_EOL;
			$fp = fopen(ROOT.DS.'passwords', 'a');
			fwrite($fp, $data);
		}
	}
}
