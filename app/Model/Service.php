<?php
App::uses('AppModel', 'Model');

class Service extends AppModel {
    public $name = 'Service';
    public $useTable='activity';
    
    protected $sql = [
        'get_services' => [
            'sql' => 'get_services.sql',
            'params' => []
        ],
        'get_services_by_category' => [
            'sql' => 'get_services_by_category.sql',
            'params' => []
        ],
        'get_agency_services' => [
            'sql' => 'get_agency_services.sql',
            'params' => []
        ],
        'get_service_categories' => [
            'sql' => 'get_service_categories.sql',
            'params' => []
        ],
        'create_service_to_agency' => [
            'sql' => 'create_service_to_agency.sql',
            'params' => []
        ],
        'delete_service_to_agency' => [
            'sql' => 'delete_service_to_agency.sql',
            'params' => []
        ],
        'filter_service' => [
            'sql' => 'filter_service.sql',
            'params' => []
        ],
    ];

    public function format_active_service_ids(&$data){
        $result = [];
        foreach ($data as $service_id) {
            $result[] = $service_id[0]['service_id'];
        }

        return $result;
    }
}