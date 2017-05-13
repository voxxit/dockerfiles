#!/bin/bash

trap ctrl_c INT

function ctrl_c() {
  echo
  echo "Exiting..."

  exit 130
}

[ -z $S3_INVENTORY_SOURCE_BUCKET ] && echo "S3_INVENTORY_SOURCE_BUCKET is empty; try again!" && exit 1
[ -z $S3_INVENTORY_NAME ] && echo "S3_INVENTORY_NAME is empty; try again!" && exit 1
[ -z $S3_INVENTORY_DESTINATION_BUCKET ] && echo "S3_INVENTORY_DESTINATION_BUCKET is empty; try again!" && exit 1
[ -z $S3_INVENTORY_DESTINATION_PREFIX ] && echo "S3_INVENTORY_DESTINATION_PREFIX is empty; try again!" && exit 1

# Determine the latest available manifests:
manifests=$(\
  aws s3api list-objects-v2 --bucket ${S3_INVENTORY_DESTINATION_BUCKET} \
    --prefix ${S3_INVENTORY_DESTINATION_PREFIX}/${S3_INVENTORY_SOURCE_BUCKET}/${S3_INVENTORY_NAME} | \
  jq -r .Contents[].Key | \
  grep manifest.checksum | \
  sed 's/\/manifest.checksum$//' | \
  cut -d/ -f5 | \
  tail -n10
)

# Prompt for which manifest to fetch
PS3="Choose a manifest option (or press CTRL+C to exit): "

# Show a menu and ask for input. If the user entered a valid choice,
# then invoke the command to download the parts and compile them
select manifest in ${manifests}; do
  if [[ -n "${manifest}" ]]; then
    cd /out

    # Download the manifest JSON and checksum:
    aws s3 cp s3://${S3_INVENTORY_DESTINATION_BUCKET}/${S3_INVENTORY_DESTINATION_PREFIX}/${S3_INVENTORY_SOURCE_BUCKET}/${S3_INVENTORY_NAME}/${manifest}/manifest.json .

    aws s3 cp s3://${S3_INVENTORY_DESTINATION_BUCKET}/${S3_INVENTORY_DESTINATION_PREFIX}/${S3_INVENTORY_SOURCE_BUCKET}/${S3_INVENTORY_NAME}/${manifest}/manifest.checksum .

    # Download each file part listed in the manifest:
    parts=$(cat manifest.json | jq -r .files[].key)

    for part in ${parts}; do
      file=$(echo ${part} | cut -f6 -d/)

      aws s3 cp s3://${S3_INVENTORY_DESTINATION_BUCKET}/${S3_INVENTORY_DESTINATION_PREFIX}/${S3_INVENTORY_SOURCE_BUCKET}/${S3_INVENTORY_NAME}/data/${file} .

      if [ $? != 0 ]; then
        echo "One of the parts was not able to be downloaded. Please check that all parts of the manifest exist, and try again!"
        exit 1
      fi
    done

    outDir="/out/${S3_INVENTORY_SOURCE_BUCKET}/${S3_INVENTORY_NAME}"
    outFile="${manifest}.csv"

    mkdir -p ${outDir}

    # Decompress the file, then on success, delete the source .csv.gz files
    zcat *.csv.gz | pv --progress --size `gzip -l *.csv.gz | tail -n1 | awk '{print $2}'` --name 'Expanding...' > ${outDir}/${outFile} && rm -f *.csv.gz

    echo "Inventory file available in the output directory:"
    echo
    echo "${outDir}/${outFile}"

    exit 0
  fi
done
