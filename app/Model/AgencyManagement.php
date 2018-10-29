<?php
App::uses('AppModel', 'Model');

class AgencyManagement extends AppModel {
    public $name = 'AgencyManagement';
    public $useTable='agency_management';
    
    protected $sql = [
        'get_management' => [
            'sql' => 'get_management.sql',
            'params' => []
        ],
        'get_management_entity' => [
            'sql' => 'get_management_entity.sql',
            'params' => []
        ],
        'create_management' => [
            'sql' => 'create_management.sql',
            'params' => []
        ],
        'update_management' => [
            'sql' => 'update_management.sql',
            'params' => []
        ],
        'delete_management' => [
            'sql' => 'delete_management.sql',
            'params' => []
        ],
    ];
}