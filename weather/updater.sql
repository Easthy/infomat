BEGIN TRANSACTION;

WITH up AS (
	UPDATE 
		public.weather 
	SET 
		load_date='{load_date}', 
		temperature={temperature}, 
		weather_json='{weather_json}'::jsonb 
	RETURNING *
) 
INSERT INTO public.weather(load_date, temperature, weather_json) 
SELECT '{load_date}', {temperature}, '{weather_json}'::jsonb 
WHERE NOT EXISTS(SELECT 1 FROM up)
; 

END TRANSACTION;