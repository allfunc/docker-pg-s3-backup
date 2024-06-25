#!/usr/bin/env sh

db=$1
timestamp=$2
tmp_name='backup_'$db'_'$timestamp
tmp_backup_folder='/tmp/backup/backup_'$timestamp
tmp_file=$tmp_backup_folder'/'$tmp_name'.dump'
mkdir -p $tmp_backup_folder

pg_dump --format=custom \
  -h $POSTGRES_HOST \
  -p $POSTGRES_PORT \
  -U $POSTGRES_USER \
  -d $db \
  $PGDUMP_EXTRA_OPTS \
  > $tmp_file

realpath ${tmp_file}
