insert into agency_photo_album(name,agency_id,description)
values (  :name, :agency_id, :description )
returning id
;