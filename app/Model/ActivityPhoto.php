<?php
App::uses('AppModel', 'Model');

class ActivityPhoto extends AppModel {
    public $name = 'ActivityPhoto';
    public $useTable='activity_photo';
    
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
                'activity_photo_table' => 'activity_photo',
            ]
        ],
        'delete_photo_by_filename' => [
            'sql' => 'delete_photo_by_filename.sql',
            'params' => [],
            'template_fields' => [
                'activity_photo_table' => 'activity_photo',
            ]
        ],
        'delete_photo_by_activity' => [
            'sql' => 'delete_photo_by_activity.sql',
            'params' => [],
            'template_fields' => [
                'activity_photo_table' => 'activity_photo',
            ]
        ],
        'delete_photo' => [
            'sql' => 'delete_photo.sql',
            'params' => [],
            'template_fields' => [
                'activity_photo_table' => 'activity_photo',
            ]
        ],
        'get_photo_by_activity' => [
            'sql' => 'get_photo_by_activity.sql',
            'params' => [],
            'template_fields' => [
                'activity_photo_table' => 'activity_photo',
            ]
        ],
    ];
}