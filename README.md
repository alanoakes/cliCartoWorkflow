# Automate Cartography with D3 and bash

I have been manually practicing with different cartographic projections and sub-setting boundaries. D3, mapshaper and bash are the best cli tools to use for this. D3 has several options for cartographic datapreprocessing and bash works very well with automating node/npm tasks.

## Cartographic Pre-Processing
This is a manually sub-setted cartographic shapefile from the TIGER ftp server and transformed coordinates with Conic Equal Area projection. Then made into an SVG, GeoJSON and TopoJSON. You can use this cli process on any shapefile.

[Here is a link to Mike Bostock's "CLI Cartography" article that helped me understand these tools](https://medium.com/@mbostock/command-line-cartography-part-1-897aa8f8ca2c)

<img src="https://github.com/alanoakes/cliCartoWorkflow/raw/master/Shelby%20County%20Tracts.PNG" alt="Shelby County Albers" width="600" height="600">
