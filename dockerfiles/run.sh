#!/bin/bash

retrievedata(){
    newData=`curl -s https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_$1.geojson`
    echo $newData | jq '.features[]' | jq '[.properties.place, .geometry.coordinates[0,1], .properties.mag]' | jq '((.[2]|tostring) + "|" + (.[1]|tostring) + "|" + .[0] + "|" + (.[3]|tostring))' | jq -r . > hour.chi
    /opt/chimera/bin/cliapp -i hour.chi --dataset-name "all_$1" -r
    rm hour.chi
    echo "Dataset 'all_$1' created."
}

retrievedata 'hour'
retrievedata 'day'
retrievedata 'week'