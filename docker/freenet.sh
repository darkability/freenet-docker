#!/bin/bash

sudo chown -R freenet:freenet .

echo "Input: ${INPUT_BANDWIDTH}"
echo "Output: ${OUTPUT_BANDWIDTH}"
echo "Store: ${STORE_SIZE}"

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
