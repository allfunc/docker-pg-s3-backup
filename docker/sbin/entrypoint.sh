#!/usr/bin/env sh

# docker entrypoint script
server() {
  tail -f /usr/local/sbin/entrypoint.sh
}

S3_S3V4=${S3_S3V4:-}
if [ -n "$S3_S3V4" ]; then
  aws configure set default.s3.signature_version s3v4
fi

if [ "$1" = 'server' ]; then
  server
else
  exec "$@"
fi
