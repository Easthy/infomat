<?php
App::uses('AppModel', 'Model');

class AgencyPhoto extends AppModel {
    public $name = 'AgencyPhoto';
    public $useTable='agency_photo';
    public $sql_dir = 'AgencyPhoto';
    protected $sql = [
        'get_photos' => [
            'sql' => 'get_photos.sql',
            'params' => []
        ],
        'create_photo' => [
            'sql' => 'create_photo.sql',
            'params' => []
        ],
        'delete_photo' => [
            'sql' => 'delete_photo.sql',
            'params' => []
        ],
        'delete_photo_by_filename' => [
            'sql' => 'delete_photo_by_filename.sql',
            'params' => []
        ],
    ];
}