<?php
App::uses('AppModel', 'Model');

class Agency extends AppModel {
    public $name = 'Agency';
    public $useTable='agency';
    public $sql_dir = 'Agency';

    protected $sql = [
        'get_agency_list' => [
            'sql' => 'get_agency_list.sql',
            'params' => []
        ],
        'get_schedule' => [
            'sql' => 'get_schedule.sql',
            'params' => []
        ],
        'update_schedule' => [
            'sql' => 'update_schedule.sql',
            'params' => []
        ],
        'get_description' => [
            'sql' => 'get_description.sql',
            'params' => []
        ],
        'update_description' => [
            'sql' => 'update_description.sql',
            'params' => []
        ],
        'get_contacts' => [
            'sql' => 'get_contacts.sql',
            'params' => []
        ],
        'get_contact' => [
            'sql' => 'get_contact.sql',
            'params' => []
        ],
        'create_contact' => [
            'sql' => 'create_contact.sql',
            'params' => []
        ],
        'update_contact' => [
            'sql' => 'update_contact.sql',
            'params' => []
        ],
        'delete_contact' => [
            'sql' => 'delete_contact.sql',
            'params' => []
        ],
    ];
}