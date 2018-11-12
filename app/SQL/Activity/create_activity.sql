insert into {{activity_table}}
(agency_id, name, description, address, schedule, category_id, periodicity_id, type_id, start_date, end_date) 
values (:agency_id, :name, :description, :address, :schedule, :category_id, :periodicity_id, :type_id, :start_date, :end_date);