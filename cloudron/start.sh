#!/bin/bash

## This file builds Outline env variables from Cloudron variables
#
# Here's a list of all env variables made available by Cloudron
#
### Postgres
# CLOUDRON_POSTGRESQL_URL=       # the postgresql url
# CLOUDRON_POSTGRESQL_USERNAME=  # username
# CLOUDRON_POSTGRESQL_PASSWORD=  # password
# CLOUDRON_POSTGRESQL_HOST=      # server name
# CLOUDRON_POSTGRESQL_PORT=      # server port
# CLOUDRON_POSTGRESQL_DATABASE=  # database name
# 
### REDIS
# CLOUDRON_REDIS_URL=            # the redis url
# CLOUDRON_REDIS_HOST=           # server name
# CLOUDRON_REDIS_PORT=           # server port
# CLOUDRON_REDIS_PASSWORD=       # password

set -eu

# ensure that data directory is owned by 'cloudron' user
chown -R cloudron:cloudron /app/data

cd /app/code

ENV_FILE=/app/data/.env

if [ ! -f "$ENV_FILE" ]; then
    echo "[ERROR] No env file!"
    echo "Use the template at https://github.com/tokilabs/outline/blob/main/.env.sample"
    echo "to create a .env file and save it to $ENV_FILE"
    exit -1
fi

echo "Updating env from $ENV_FILE"

set -o allexport
set -a

source $ENV_FILE

export SECRET_KEY=$SECRET_KEY 
export UTILS_SECRET=$UTILS_SECRET 
export URL=$URL 
export PORT=$PORT 
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID 
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY 
export AWS_REGION=$AWS_REGION 
export AWS_S3_UPLOAD_BUCKET_URL=$AWS_S3_UPLOAD_BUCKET_URL 
export AWS_S3_UPLOAD_BUCKET_NAME=$AWS_S3_UPLOAD_BUCKET_NAME 
export AWS_S3_UPLOAD_MAX_SIZE=$AWS_S3_UPLOAD_MAX_SIZE 
export AWS_S3_FORCE_PATH_STYLE=$AWS_S3_FORCE_PATH_STYLE 
export AWS_S3_ACL=$AWS_S3_ACL 
export SLACK_KEY=$SLACK_KEY 
export SLACK_SECRET=$SLACK_SECRET 
export GOOGLE_CLIENT_ID=$GOOGLE_CLIENT_ID 
export GOOGLE_CLIENT_SECRET=$GOOGLE_CLIENT_SECRET 
export AZURE_CLIENT_ID=$AZURE_CLIENT_ID 
export AZURE_CLIENT_SECRET=$AZURE_CLIENT_SECRET 
export AZURE_RESOURCE_APP_ID=$AZURE_RESOURCE_APP_ID 
export CDN_URL=$CDN_URL 
export FORCE_HTTPS=$FORCE_HTTPS 
export ENABLE_UPDATES=$ENABLE_UPDATES 
export MAXIMUM_IMPORT_SIZE=$MAXIMUM_IMPORT_SIZE 
export DEBUG=$DEBUG 
export ALLOWED_DOMAINS=$ALLOWED_DOMAINS 
export SLACK_VERIFICATION_TOKEN=$SLACK_VERIFICATION_TOKEN 
export SLACK_APP_ID=$SLACK_APP_ID 
export SLACK_MESSAGE_ACTIONS=$SLACK_MESSAGE_ACTIONS 
export GOOGLE_ANALYTICS_ID=$GOOGLE_ANALYTICS_ID 
export SENTRY_DSN=$SENTRY_DSN 
export SMTP_HOST=$SMTP_HOST 
export SMTP_PORT=$SMTP_PORT 
export SMTP_USERNAME=$SMTP_USERNAME 
export SMTP_PASSWORD=$SMTP_PASSWORD 
export SMTP_FROM_EMAIL=$SMTP_FROM_EMAIL 
export SMTP_REPLY_EMAIL=$SMTP_REPLY_EMAIL 
export DEFAULT_LANGUAGE=$DEFAULT_LANGUAGE 
export PGSSLMODE=$PGSSLMODE 
export DATABASE_URL=$CLOUDRON_POSTGRESQL_URL 
export REDIS_URL=$CLOUDRON_REDIS_URL

set +a
set +o allexport

echo "Environment updated"

# export $(grep -v '^#' $ENV_FILE | xargs -d '\n')

echo "Running migrations"
( exec yarn db:migrate --env=production-ssl-disabled )

echo "Starting Outline app"

# run the app as user 'cloudron'
exec /usr/local/bin/gosu cloudron:cloudron node /app/code/build/server/index.js

