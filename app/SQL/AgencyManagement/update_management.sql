update agency_management
set surname = :surname, firstname = :firstname, fathername = :fathername, post = :post, phone = :phone, path = :path
where agency_id = :agency_id and id = :id;