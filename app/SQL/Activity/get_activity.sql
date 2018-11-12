select 
	activity.*, 
	ap.path as path 
from {{activity_table}} as activity 
left join {{activity_photo_table}} ap on activity.id = ap.activity_id
where activity.id = :id;