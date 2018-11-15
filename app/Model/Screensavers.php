<?php
App::uses('AppModel', 'Model');

class Screensavers extends AppModel {
    public $name = 'Screensavers';
    public $useTable='screen_saver';
    public $sql_dir = 'Screensavers';
    protected $sql = [
        'get_agency_screensavers' => [
            'sql' => 'get_agency_screensavers.sql',
            'params' => []
        ],
    ];
}