# AWS S3 Inventory Fetcher

* Automates the work of finding and parsing the S3 Storage Inventory manifest files
* Ensures incomplete manifests are never allowed to be used
* Automates the download/decompressing/compiling steps for all data
* Provides a progress bar for each step of the way

### Requirements

* AWS Credentials
  * Run `aws configure` on your local machine
* AWS IAM user with read access to the bucket containing the inventories

### Environment Variables

* `S3_INVENTORY_SOURCE_BUCKET` - bucket the inventory was configured for
* `S3_INVENTORY_NAME` - name of the inventory
* `S3_INVENTORY_DESTINATION_BUCKET` - bucket where the inventories are stored
* `S3_INVENTORY_DESTINATION_PREFIX` - prefix inside the bucket where the inventories are stored

### Usage

````
docker run --rm -it \
  -e S3_INVENTORY_SOURCE_BUCKET=source_bucket \
  -e S3_INVENTORY_NAME=all \
  -e S3_INVENTORY_DESTINATION_BUCKET=inventory_bucket \
  -e S3_INVENTORY_DESTINATION_PREFIX=inventories \
  -v $HOME/.aws/credentials:/root/.aws/credentials:ro \
  -v `pwd`/out:/out \
  voxxit/s3-inventory-fetcher:latest
```

The result will be stored in the `out/` folder of your working directory.

Enjoy!
