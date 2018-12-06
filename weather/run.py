import os
import requests
import json
import psycopg2
from datetime import datetime

DS = '/'
dir_path = os.path.dirname(os.path.realpath(__file__))
settings_file = 'settings.json'
settings_path = dir_path + DS + settings_file

# Load settings file
if not os.path.isfile(settings_path):
    error = 'Settings file must be placed at directory of updater!'
    raise Exception(error)

with open( settings_path, 'r') as f:
    settings = json.loads(f.read())
f.close()

# Query parameters
city_id = settings['city_id']
url = 'http://dataservice.accuweather.com/currentconditions/v1/'+city_id
apikey = settings['apikey']
params = {'language': 'ru-RU', 'details': True, 'apikey': apikey}


# DB connections
def db_connect(settings):
    """ Connect to the PostgreSQL database server """
    conn = None
    try:
        # read connection parameters
        params = settings['infomat_db']
        # connect to the PostgreSQL server
        return psycopg2.connect(**params)
    except (Exception, psycopg2.DatabaseError) as error:
        raise Exception(str(error))
    finally:
        if conn is not None:
            conn.close()

def update(response, settings):
    """UPSERT weather data"""
    updater_sql_path = ''.join([dir_path, DS, settings["updater_sql_path"]])
    with open( updater_sql_path, 'r') as f:
        updater_sql = f.read()
    f.close()

    if response[0]:
        temperature = response[0].get('Temperature', {}).get('Metric', {}).get('Value', None)
        load_date = datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%S')
        updater_sql = updater_sql.format(
            load_date = load_date,
            temperature = temperature,
            weather_json = json.dumps(response)
        )
        db = db_connect(settings)
        cursor = db.cursor()
        cursor.execute(updater_sql)
        cursor.close()

# Query weather service
response = requests.get(
    url, params=params,
    headers={'Content-Type': 'application/json'}
)
response = json.loads(response.content.decode('utf-8'))
update(response, settings)
