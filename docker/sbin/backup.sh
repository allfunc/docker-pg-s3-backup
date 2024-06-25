#!/usr/bin/env sh

echo "Creating backup of $POSTGRES_DATABASE database..."
echo

timestamp=$(date +"%Y-%m-%dT%H:%M:%S")

for db in $POSTGRES_DATABASE; do
  local_file=$(dump-db.sh $db $timestamp)
  local_base=$(basename -s ".dump" "$local_file")
  remote_file=${local_base}'.dump'
  sync_to_s3.sh ${local_file} ${remote_file}
done

exit
