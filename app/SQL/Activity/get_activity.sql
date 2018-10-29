select activity.*, ap.path as path from activity
left join activity_photo ap on activity.id = ap.activity_id
where activity.id = :id;