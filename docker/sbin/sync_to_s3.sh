#!/usr/bin/env sh
DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)"

local_file_name=$1
remote_file_name=$2

S3_URL=$(${DIR}/ver_S3_URL.sh)
S3_REGION=$(${DIR}/ver_S3_REGION.sh)
S3_BUCKET=$(${DIR}/ver_S3_BUCKET.sh)
export AWS_ACCESS_KEY_ID=$(ver_S3_ACCESS_KEY_ID.sh)
export AWS_SECRET_ACCESS_KEY=$(ver_S3_SECRET_ACCESS_KEY.sh)

# https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-options.html
aws_args=""
if [ -n "$S3_URL" ]; then
  aws_args="$aws_args --endpoint-url $S3_URL"
fi
if [ -n "$S3_REGION" ]; then
  aws_args="$aws_args --region $S3_REGION"
fi

s3_uri="s3://${S3_BUCKET}/${remote_file_name}"
cli='aws '$aws_args' s3 cp "'$local_file_name'" "'$s3_uri'"'

echo ---
echo 'Local : '$local_file_name
echo 'Remote: '$remote_file_name
echo 'CLI: '$cli
echo 'S3 URI: '$s3_uri
echo ---
echo "Uploading to $S3_BUCKET..."
sh -c "$cli"
