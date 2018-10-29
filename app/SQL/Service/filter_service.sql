select service.*, slt.text from service 
left join service_location_type slt on service.location_type_id = slt.id
left join service_chargeable_type_to_service sc on service.id = sc.service_id
where category_id = (case when :category_id = 0 then category_id else  :category_id end) 
and (case when :chargeable_type_id = 0 then (sc.chargeable_type_id = chargeable_type_id or sc.chargeable_type_id is null) else  sc.chargeable_type_id = :chargeable_type_id end)
group by service.id, slt.text;