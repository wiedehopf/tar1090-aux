#!/bin/bash
set -e

wget -O tfrs.geojson "http://tfr.faa.gov/geoserver/TFR/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=TFR:V_TFR_LOC&outputFormat=json"
jq < tfrs.geojson '.crs.properties.name = "urn:ogc:def:crs:OGC:1.3:CRS84"' > tfrs.geojson.tmp
mv tfrs.geojson.tmp tfrs.geojson

git add tfrs.geojson
git commit --amend --date "$(date)" -m "aux update"
git push -f
