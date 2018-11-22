SELECT
	screen_saver.id,
	screen_saver.name,
	screen_saver.agency_id,
	screen_saver.description,
	screen_saver.active,
	screen_file.link_file
FROM
	public.screen_saver
INNER JOIN screen_file
ON screen_file.screensaver_id = screen_saver.id
WHERE
	screen_saver.agency_id = :agency_id
ORDER BY screen_saver.id DESC
;
