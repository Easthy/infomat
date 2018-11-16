<?php
App::uses('AppModel', 'Model');

class ScreenFile extends AppModel {
    public $name = 'ScreenFile';
    public $useTable='screen_file';
    public $sql_dir = 'ScreenFile';
    protected $sql = [
    ];
}