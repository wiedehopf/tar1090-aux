#!/bin/bash
set -e

wget -O tfrs.geojson "http://tfr.faa.gov/geoserver/TFR/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=TFR:V_TFR_LOC&outputFormat=json"
jq '.crs.properties.name = "urn:ogc:def:crs:OGC:1.3:CRS84"' < tfrs.geojson > tfrs.geojson.tmp
# reduce number precision
sed -E -e 's/\s*([0-9-]+\.[0-9]{5})[0-9]*/\1/' < tfrs.geojson.tmp | jq -c > tfrs.geojson

#exit

git add tfrs.geojson
git commit --amend --date "$(date)" -m "aux update"
git push -f
