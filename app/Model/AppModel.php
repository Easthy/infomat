<?php
/**
 * Application model for CakePHP.
 *
 * This file is application-wide model file. You can put all
 * application-wide model-related methods here.
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
 * @package       app.Model
 * @since         CakePHP(tm) v 0.2.9
 * @license       https://opensource.org/licenses/mit-license.php MIT License
 */

App::uses('Model', 'Model');
App::import('Vendor', 'Templater', APP.'Templater.php');

class AppModel extends Model {
    public $base_path = APP.'SQL'.DS;

    public static function get_agency_id(){
        return CakeSession::read('Auth.User.agency_id');
    }
    
    public static function get_user_id(){
        return CakeSession::read('Auth.User.id');
    }
    
    public static function get_username(){
        return CakeSession::read('Auth.User.username');
    }

    public static function get_user_role(){
        return CakeSession::read('Auth.User.role');
    }

    public function get_data($query_method, array $params=array(), $process_method=false){
        $template_fields = !empty($this->sql[$query_method]['template_fields'])?$this->sql[$query_method]['template_fields']:array();
        $params_ = array_merge(
            $params, 
            $this->sql[$query_method]['params']
        );
        $data = $this->query_from_file(
            $this->sql[$query_method]['sql'],
            $params_,
            $template_fields
        );
        if ( $process_method ){
            $data = $this->{$process_method}($data);
        }
        return $data;
    }
    
    public function query_from_file($sql_file,$params,$template_fields=array()) {
        $sql_file_path = $this->base_path.($this->sql_dir).DS.$sql_file;
        $sql_file = fopen($sql_file_path, "r") or die("Unable to open sql-file!");
        $sql_template = new Templater($sql_file_path);
        $sql_template->set_params($template_fields);
        // debug($sql_template->get_content());exit('!');
        // $sql = fread($sql_file,filesize($sql_file_path));
        return $this->query($sql_template->get_content(),$params);
    }
}
