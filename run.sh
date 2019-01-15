#!/bin/bash

if [ ! -f /home/renderer/osrm/firststart ]; then
   
    # Download if no data is provided
    if [ ! -f /home/renderer/osm/data.osm.pbf ]; then
        echo "WARNING: No import file at /data.osm.pbf, so importing Niedersachsen as example..."
        wget -nv http://download.geofabrik.de/europe/germany/niedersachsen-latest.osm.pbf -O /home/renderer/osrm/data.osm.pbf
      
    fi
    
    cd /home/renderer/osrm/
    osrm-extract -p /home/renderer/osrm/profile.lua  /home/renderer/osrm/data.osm.pbf
    osrm-partition data.osrm
    osrm-customize data.osrm    
    touch /home/renderer/osrm/firststart
fi

osrm-routed --algorithm mld data.osrm
exit 0
