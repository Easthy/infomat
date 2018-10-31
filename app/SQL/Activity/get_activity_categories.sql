select id, name, counter
from activity_category
left join (select category_id, count(1) as counter from activity where agency_id = :agency_id group by category_id) as activity_by_cat 
on activity_category.id = activity_by_cat.category_id;