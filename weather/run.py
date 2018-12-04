import os
import requests
import json
import psycopg2
import subprocess
import logging
import signal
import hashlib
import atexit 

DS = '/'
dir_path = os.path.dirname(os.path.realpath(__file__))
settings_file = 'settings.json'
settings_path = dir_path + DS + settings_file

if not os.path.isfile(settings_path):
    error = 'Settings file must be placed at directory of updater!'
    raise Exception(error)

with open( settings_path, 'r') as f:
    settings = json.loads(f.read())
f.close()

city_id = settings['city_id']
url = 'http://dataservice.accuweather.com/currentconditions/v1/'+city_id
apikey = settings['apikey']
params = {'language': 'ru-RU', 'details': True, 'apikey': apikey}

response = requests.get(
    url, params=params,
    headers={'Content-Type': 'application/json'}
)

temperature = None
if response.status_code == 200:
	response = json.loads(response.content.decode('utf-8'))
	if response[0]:
		temperature = response[0].get('Temperature', {}).get('Metric', {}).get('Value', None)


print(temperature)