update activity
set name = :name, description = :description,
address = :address, schedule = :schedule,  start_date = :start_date, end_date = :end_date, category_id = :category_id, periodicity_id = :periodicity_id
where id = :id;