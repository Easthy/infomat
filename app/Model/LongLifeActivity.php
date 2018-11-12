<?php
App::uses('AppModel', 'Model');

class LongLifeActivity extends AppModel {
    public $name = 'LongLifeActivity';
    public $useTable='long_life_activity';
    
    public $sql_dir = 'Activity';

    protected $sql = [
        'get_activities' => [
            'sql' => 'get_activities.sql',
            'params' => [],
            'template_fields' => [
                'activity_table' => 'long_life_activity',
                'activity_category_table' => 'long_life_activity_category',
                'activity_photo_table' => 'long_life_activity_photo'
            ]
        ],
        'get_activities_by_category' => [
            'sql' => 'get_activities_by_category.sql',
            'params' => [],
            'template_fields' => [
                'activity_table' => 'long_life_activity',
                'activity_category_table' => 'long_life_activity_category',
                'activity_photo_table' => 'long_life_activity_photo'
            ]
        ],
        'get_activity_categories' => [
            'sql' => 'get_activity_categories.sql',
            'params' => [],
            'template_fields' => [
                'activity_table' => 'long_life_activity',
                'activity_category_table' => 'long_life_activity_category',
            ]
        ],
        'get_activity_periodicity' => [
            'sql' => 'get_activity_periodicity.sql',
            'params' => [],
            'template_fields' => [
                'activity_periodicity_table' => 'activity_periodicity',
            ]
        ],
        'get_activity' => [
            'sql' => 'get_activity.sql',
            'params' => [],
            'template_fields' => [
                'activity_table' => 'long_life_activity',
                'activity_photo_table' => 'long_life_activity_photo'
            ]
        ],
        'get_last_inserted' => [
            'sql' => 'get_last_inserted.sql',
            'params' => [],
            'template_fields' => [
                'activity_id_seq' => 'long_life_activity_id_seq',
            ]
        ],
        'create_activity' => [
            'sql' => 'create_activity.sql',
            'params' => [],
            'template_fields' => [
                'activity_table' => 'long_life_activity'
            ]
        ],
        'update_activity' => [
            'sql' => 'update_activity.sql',
            'params' => [],
            'template_fields' => [
                'activity_table' => 'long_life_activity'
            ]
        ],
        'delete_activity' => [
            'sql' => 'delete_activity.sql',
            'params' => [],
            'template_fields' => [
                'activity_table' => 'long_life_activity'
            ]
        ],
    ];
}