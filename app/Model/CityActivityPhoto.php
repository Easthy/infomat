<?php
App::uses('AppModel', 'Model');

class CityActivityPhoto extends AppModel {
    public $name = 'CityActivityPhoto';
    public $useTable='city_activity_photo';
    
    public $sql_dir = 'ActivityPhoto';

    protected $sql = [
        // 'get_photos' => [
        //     'sql' => 'get_photos.sql',
        //     'params' => []
        // ],
        'create_photo' => [
            'sql' => 'create_photo.sql',
            'params' => [],
            'template_fields' => [
                'activity_photo_table' => 'city_activity_photo',
            ]
        ],
        'delete_photo_by_filename' => [
            'sql' => 'delete_photo_by_filename.sql',
            'params' => [],
            'template_fields' => [
                'activity_photo_table' => 'city_activity_photo',
            ]
        ],
        'delete_photo_by_activity' => [
            'sql' => 'delete_photo_by_activity.sql',
            'params' => [],
            'template_fields' => [
                'activity_photo_table' => 'city_activity_photo',
            ]
        ],
        'delete_photo' => [
            'sql' => 'delete_photo.sql',
            'params' => [],
            'template_fields' => [
                'activity_photo_table' => 'city_activity_photo',
            ]
        ],
        'get_photo_by_activity' => [
            'sql' => 'get_photo_by_activity.sql',
            'params' => [],
            'template_fields' => [
                'activity_photo_table' => 'city_activity_photo',
            ]
        ],
    ];
}