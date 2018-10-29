select activity.*, ac.name as cname, ap.path as path from activity
left join activity_category as ac on activity.category_id = ac.id
left join activity_photo as ap on activity.id = ap.activity_id
where agency_id = :agency_id;