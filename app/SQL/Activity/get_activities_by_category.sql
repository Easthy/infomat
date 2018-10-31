select activity.*, ac.name as cname, ap.path as path from activity
left join activity_category as ac on activity.category_id = ac.id
left join activity_photo as ap on activity.id = ap.activity_id
where category_id = :category_id and agency_id = :agency_id;