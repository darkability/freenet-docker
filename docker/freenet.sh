#!/bin/bash

# If open access, drop 127.0.0.1 restriction
if [ "${ACCESS_MODE}" = "open" ]; then
  echo "Replacing localhost with wildcard"
  sed -i 's/127.0.0.1,0:0:0:0:0:0:0:1/*/g' freenet.ini
fi

# IO bandwidth and datastore size need customizing
sed -i "s/{{ output_bandwidth }}/${OUTPUT_BANDWIDTH}/g" freenet.ini
sed -i "s/{{ input_bandwidth }}/${INPUT_BANDWIDTH}/g" freenet.ini
sed -i "s/{{ store_size }}/${STORE_SIZE}/g" freenet.ini

# Persistent directories
mkdir -p mount/persistent-temp && \
  ln -s "${PWD}/mount/persistent-temp" "persistent-temp"
mkdir -p mount/downloads && \
  ln -s "${PWD}/mount/downloads" "downloads"
mkdir -p mount/datastore && \
  ln -s "${PWD}/mount/datastore" "datastore"

./run.sh console
