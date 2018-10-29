<?php
App::uses('AppModel', 'Model');

class Activity extends AppModel {
    public $name = 'Activity';
    public $useTable='activity';
    
    protected $sql = [
        'get_activities' => [
            'sql' => 'get_activities.sql',
            'params' => []
        ],
        'get_activities_by_category' => [
            'sql' => 'get_activities_by_category.sql',
            'params' => []
        ],
        'get_activity_categories' => [
            'sql' => 'get_activity_categories.sql',
            'params' => []
        ],
        'get_activity_periodicity' => [
            'sql' => 'get_activity_periodicity.sql',
            'params' => []
        ],
         'get_activity' => [
            'sql' => 'get_activity.sql',
            'params' => []
        ],
        'get_last_inserted' => [
            'sql' => 'get_last_inserted.sql',
            'params' => []
        ],
        'create_activity' => [
            'sql' => 'create_activity.sql',
            'params' => []
        ],
        'update_activity' => [
            'sql' => 'update_activity.sql',
            'params' => []
        ],
        'delete_activity' => [
            'sql' => 'delete_activity.sql',
            'params' => []
        ],
    ];
}