<?php
App::uses('AppModel', 'Model');

class AgencyPhotoAlbum extends AppModel {
    public $name = 'AgencyPhotoAlbum';
    public $useTable='agency_photo_album';
    
    protected $sql = [
        'get_album' => [
            'sql' => 'get_album.sql',
            'params' => []
        ],
    ];
}