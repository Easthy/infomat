update agency
set fullname = :fullname, shortname = :shortname, 
address = :address, address_comment = :address_comment,  www = :www, email = :email, phone = :phone
where id = :id;