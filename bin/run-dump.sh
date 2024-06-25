#!/usr/bin/env sh

DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)"

localImage=$(${DIR}/../support/localImage.sh)
pid=$$
folderName=${PWD##*/}

C=''
for i in "$@"; do
  i="${i//\\/\\\\}"
  C="$C \"${i//\"/\\\"}\""
done

cli='env docker run --rm'
cli+=" -v $DIR/../docker/entrypoint.sh:/entrypoint.sh"
cli+=" -v $DIR/../tmp:/tmp/backup"
cli+=" -e POSTGRES_HOST=host.docker.internal"
cli+=" -e 'POSTGRES_DATABASE=postgres'"
cli+=" --name ${folderName}-${pid} ${localImage} ${C}"
echo $cli
sh -c "$cli"
