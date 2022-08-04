#!/usr/bin/env bash

#Add your curl statements here
HOST="http://couchdb:5984"
curl $HOST
curl -X GET $HOST/_all_dbs

# Use cURL to create a new database with a name of restaurants.
curl -X PUT $HOST/restaurants

# Add 3 documents for the restaurants database with the fields _id (the id should be the name of the restaurant with underscores - for example, taste_of_thai), name, food_type (American, Chinese, Mexican, Thai, etc), phonenumber, and website.
# The food_type will be an array.
curl -i -X POST "$HOST/restaurants" -H "Content-Type: application/json" -d '{ "_id": "subway", "name": "Subway", "food_type": ["American","Sandwich"], "phonenumber":"2173449220", "website":"https://order.subway.com/en-us/"}'
curl -i -X POST "$HOST/restaurants" -H "Content-Type: application/json" -d '{ "_id": "panda_express", "name": "Panda Express", "food_type": ["American","Chinese"], "phonenumber":"2173671371", "website":"https://www.pandaexpress.com"}'
curl -i -X POST "$HOST/restaurants" -H "Content-Type: application/json" -d '{ "_id": "sarku_japan", "name": "Sarku Japan", "food_type": ["American","Japanese"], "phonenumber":"2173788028", "website":"https://www.sarkujapan.com"}'

#DO NOT REMOVE
curl -Ssf -X PUT http://couchdb:5984/restaurants/_design/docs -H "Content-Type: application/json" -d '{"views": {"all": {"map": "function(doc) {emit(doc._id, {rev:doc._rev, name:doc.name, food_type:doc.food_type, phonenumber:doc.phonenumber, website:doc.website})}"}}}'
curl -Ssf -X GET http://couchdb:5984/restaurants/_design/docs/_view/all