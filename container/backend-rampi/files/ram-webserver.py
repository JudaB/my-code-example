#!/usr/bin/env python3
#
# Juda Barnes (c) - 06/12/2021
# Flask backend script for Rick and Morty API data
#

import json
import pprint
import requests
import sys
from flask import Flask, request, jsonify
from flask_cors import CORS  # Import flask-cors

# Initialize Flask app
app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Array that will hold characters according to the filter
WebserverData = []

def getRamPage(page=1):
    url = "https://rickandmortyapi.com/api/character/?status=alive&species=human&page=" + str(page)
    APIResult = requests.get(url)
    if APIResult.status_code != 200:
        print("API returned a bad response")
        return None, None
    data = APIResult.json()
    return data['results'], data['info']['next']

# Initialize variables
Data = []
NextPage = None
PageNumber = 1
TotalSkip = 0

# Retrieve data from the API
Data, NextPage = getRamPage(PageNumber)
while Data is not None and NextPage is not None:
    for ItemToAdd in Data:
        if ItemToAdd['origin']['name'] != "Earth (C-137)":
            newEntry = {}
            newEntry['name'] = ItemToAdd['name']
            newEntry['location'] = ItemToAdd['location']['name']
            print("Adding character name %s from %s to list. List count: %d" % (
                newEntry['name'], newEntry['location'], len(WebserverData)))
            newEntry['image'] = ItemToAdd['image']
            WebserverData.append(newEntry)
        else:
            print("Skipping character %s from %s" % (ItemToAdd['name'], ItemToAdd['origin']['name']))
            TotalSkip += 1
    PageNumber += 1
    Data, NextPage = getRamPage(PageNumber)

# Print counters
print("Total in List {} Total Skip {}".format(len(WebserverData), TotalSkip))

if len(WebserverData) < 1:
    print("List contains no data. Aborting.")
    exit(1)
else:
    @app.get("/ram")
    def get_ram():
        return jsonify(WebserverData)


