#!/bin/bash

if [ ! -f /home/renderer/osrm/firststart ]; then
   
    # Download if no data is provided
    if [ ! -f /home/renderer/osm/data.osm.pbf ]; then
        echo "WARNING: No import file at /data.osm.pbf, so importing Niedersachsen as example..."
        wget -nv http://download.geofabrik.de/europe/germany/niedersachsen-latest.osm.pbf -O /home/renderer/osrm/data.osm.pbf
        osrm-extract /home/renderer/osrm/data.osm.pbf
    fi
    cd /home/renderer/osrm/
    osrm-extract map.osm

    
    
      touch /home/renderer/osrm/firststart
fi


/usr/local/bin/osrm-routed -p 5000 map.osrm
exit 1
