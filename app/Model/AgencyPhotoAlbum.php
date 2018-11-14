<?php
App::uses('AppModel', 'Model');

class AgencyPhotoAlbum extends AppModel {
    public $name = 'AgencyPhotoAlbum';
    public $useTable='agency_photo_album';
    public $sql_dir = 'AgencyPhotoAlbum';
    protected $sql = [
        'get_album' => [
            'sql' => 'get_album.sql',
            'params' => []
        ],
        'create_album' => [
            'sql' => 'create_album.sql',
            'params' => []
        ],
    ];
}