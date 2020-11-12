#!/bin/bash

# File Environment Commands
npm init -y

# Install Dependencies
npm i shapefile d3-geo-projection ndjson-cli d3 topojson mapshaper --save

# Download & unzip Tennessee US Census Tract Cartographic Boundaries
curl 'https://www2.census.gov/geo/tiger/GENZ2019/shp/cb_2019_47_tract_500k.zip' -o cb_2019_47_tract_500k.zip
unzip cb_2019_47_tract_500k.zip

# Change Shapefile to New-Line Delimited GeoJSON 
# to filter tracts within Shelyby County
shp2json -n cb_2019_47_tract_500k.shp -o tn.ndjson
cat tn.ndjson | grep '"COUNTYFP":"157"' > shelby.ndjson

# check line count to make sure grep worked
wc -l tn.ndjson; wc -l shelby.ndjson
mapshaper tn.ndjson -info; mapshaper shelby.ndjson -info

# Return file back to regular GeoJSON
ndjson-reduce < shelby.ndjson | ndjson-map '{type: "FeatureCollection", features: d}' > shelby.json

# Prep File to View in local Directory
# 1. Project the coordinates with Conic Equal Area (i.e. US Albers)
	# The parallels are the maximum and minimum latitudes
	# The rotate uses the central longitude of the County
	# The fitsize uses 700px by 700px
geoproject 'd3.geoConicEqualArea().parallels([34.99418,35.0000]).rotate([89.916229,0]).fitSize([700,700],d)' < shelby.json > shelby-albers.json

# 2. View projection and filtered boundaries in an SVG and format
geo2svg -w 750 -h 750 < shelby-albers.json > shelby-albers.svg

# Change GeoJSON to TopoJSON to use with topojson.js
geo2topo shelby-albers.json -o shelby-albers-topo.json
# Change JSON object key to snake case
sed 's+shelby-albers+shelbyAlbersGeo+g' shelby-albers-topo.json > shelbyAlbersGeo-topo.json

