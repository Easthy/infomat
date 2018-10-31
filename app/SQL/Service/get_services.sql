select service.*, slt.text as text from service
left join service_location_type slt on service.location_type_id = slt.id
order by service.id;