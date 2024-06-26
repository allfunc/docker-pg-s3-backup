#!/usr/bin/env sh

echo "Creating backup of $POSTGRES_DATABASE database..."
echo

timestamp=$(date +"%Y-%m-%dT%H:%M:%S")

for db in $POSTGRES_DATABASE; do
  local_file=$(dump-one-db $db $timestamp)
  local_base=$(basename -s ".dump" "$local_file")
  remote_file=${local_base}'.dump'
  sync-to-s3 ${local_file} ${remote_file}
done

exit
