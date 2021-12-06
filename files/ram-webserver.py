#!/usr/bin/env python3
#
#
# 
# Juda Barnes (c) - 06/12/2021 
# Purpose of this script is to get data from RAM and Morty API interface
# Gather filtered data according specific filter and then pulish the data
# As API,
# In order to run the script you must use flask
# As the following example 
# /usr/local/bin/flask run--host=0.0.0.0
#
# otherwise if you use python3 to run the code it will not server as WebServer
# And will only show the chracters that are being added to the list
#
#


import json
import pprint
import requests
import sys
from flask import Flask, request, jsonify

# array  that will characters according the filter Specie=C-137, Humanhat will
# use for Webserver
WebserverData = [] 


# Purpose of this function to send API request to RickAndMarty Website
# And retrive Data via API,   in case of HTTP response rather than 200
# the function will return None Values
# function will return tupple, the data and the next Page for paging purposes
def getRamPage(page = 1):
  url = "https://rickandmortyapi.com/api/character/?status=alive&species=human&page="+str(page)
  APIResult=requests.get(url)
  if ( APIResult.status_code!=200 ):
      print("API Return bad response")
      return None , None
  data = APIResult.json()
  return data['results'],data['info']['next']



# Initializing Variables
Data = []
NextPage = None
PageNumber=1
# Counter for characters we skiped 
TotalSkip = 0



#
# Getting Data from Website til Next is Not null
Data, NextPage = getRamPage(PageNumber) 
while ( Data is not None and NextPage is not None ):
    # Adding the Data to List Array
    for ItemToAdd  in Data:
      # Check the origin of the character
      if ItemToAdd['origin']['name']!="Earth (C-137)":
          newEntry = {}
          newEntry['name']=ItemToAdd['name']
          newEntry['location']=ItemToAdd['location']['name']
          print ("Adding character name %s from %s to List listCount: %d" % (newEntry['name'],newEntry['location'],len(WebserverData)) )
          newEntry['image']=ItemToAdd['image']
          WebserverData.append(newEntry)
      else:
          print ("Skip character %s from %s" % (ItemToAdd['name'],ItemToAdd['origin']['name']))
          TotalSkip += 1
    # Getting the next Page
    PageNumber=PageNumber + 1 
    Data, NextPage = getRamPage(PageNumber) 


# Print Counters
print ("Total in List {} Total Skip {}".format(len(WebserverData),TotalSkip))

if len(WebserverData)<1:
  print ("List contain no data aborting")
  exit(1)
else:
  app = Flask(__name__)
  @app.get("/ram")
  def get_ram():
    return jsonify(WebserverData)