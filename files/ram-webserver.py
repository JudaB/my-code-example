#!/usr/bin/env python3

import json
import pprint


# rather than use request directly to the API interface
# i found Rampi python library which provide easy to use interface
# installation and documentation can be find here 
# https://ramapi.readthedocs.io/en/latest/installation.html#

import ramapi
from ramapi import Base
from ramapi import Character


# this library use for Python web server 
from flask import Flask, request, jsonify


# Init Variable:
juda1 = None

# Main:
ramapi.Base.api_info()
ramapi.Base.schema()

RamCharacterFiltered = ramapi.Character.filter(species='human', status='alive')

# Additional examples how to use the Library 
#juda1= ramapi.Character.get_all()
##amapi.Character.filter(species='human',status='alive')
#juda2 = ramapi.Location(4)
#ramapi.Episode([10,28]) //Takes list as parameter


# Print the list for myself in order to verify it own data
#pprint.pprint (juda1)

WebserverData = [] 
for x in RamCharacterFiltered['results']:
    newEntry = {}
    newEntry['name']=x['name']
    newEntry['location']=x['location']['name']
    newEntry['image']=x['image']
    WebserverData.append(newEntry)
    #    print(x['status'])
    # print (x['species'])

#pprint.pprint(WebserverData)



#TODO:  If Webserver Data is empty then exit with a failure
#

# Now handling Webserver
# I use this link 
# as a guide for flask https://realpython.com/api-integration-in-python/

app = Flask(__name__)

countries = [
    {"id": 1, "name": "Thailand", "capital": "Bangkok", "area": 513120},
    {"id": 2, "name": "Australia", "capital": "Canberra", "area": 7617930},
    {"id": 3, "name": "Egypt", "capital": "Cairo", "area": 1010408},
]

def _find_next_id():
    return max(country["id"] for country in countries) + 1

@app.get("/countries")
def get_countries():
    return jsonify(countries)


@app.get("/ram")
def get_ram():
    return jsonify(WebserverData)



@app.post("/countries")
def add_country():
    if request.is_json:
        country = request.get_json()
        country["id"] = _find_next_id()
        countries.append(country)
        return country, 201
    return {"error": "Request must be JSON"}, 415
