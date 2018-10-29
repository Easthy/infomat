<?php
App::uses('AppModel', 'Model');

class ActivityPhoto extends AppModel {
    public $name = 'ActivityPhoto';
    public $useTable='activity_photo';
    
    protected $sql = [
        // 'get_photos' => [
        //     'sql' => 'get_photos.sql',
        //     'params' => []
        // ],
        'create_photo' => [
            'sql' => 'create_photo.sql',
            'params' => []
        ],
        'delete_photo_by_filename' => [
            'sql' => 'delete_photo_by_filename.sql',
            'params' => []
        ],
        'delete_photo_by_activity' => [
            'sql' => 'delete_photo_by_activity.sql',
            'params' => []
        ],
        'delete_photo' => [
            'sql' => 'delete_photo.sql',
            'params' => []
        ],
        'get_photo_by_activity' => [
            'sql' => 'get_photo_by_activity.sql',
            'params' => []
        ],
    ];
}