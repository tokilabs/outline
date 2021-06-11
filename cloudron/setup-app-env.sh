#!/bin/bash

## Set your app domain here

APP_DOMAIN=""

# 👋 Welcome, we're glad you're setting up an installation of Outline. Copy this 
# file to .env or set the variables in your local environment manually. For 
# development with docker this should mostly work out  of the box other than 
# setting the Slack keys and the SECRET_KEY.


# –––––––––––––––– REQUIRED ––––––––––––––––

# # DO NOT SET THESE !!!!
# # Cloudron automatically provides Postgres and Redis,
# # the value for these are set in cloudron/start-cloudron.sh.
# # They are filled using the values provided by Cloudron via env variables
# DATABASE_URL=
# DATABASE_URL_TEST=
# REDIS_URL=

# # DO NOT CHANGE! (unless you know what you are doing)
# # Unless something changed, you need to disable SSL for connecting to 
# # Postgres addon provided by cloudron
PGSSLMODE=disable

# Generate a unique random key, you can use `openssl rand -hex 32` in terminal
# DO NOT LEAVE UNSET
SECRET_KEY=generate_a_new_key

# Generate a unique random key, you can use `openssl rand -hex 32` in terminal
# DO NOT LEAVE UNSET
UTILS_SECRET=generate_a_new_key

# URL should point to the fully qualified, publicly accessible URL. If using a
# proxy the port in URL and PORT may be different.
URL=http://localhost:3000
PORT=3000

# To support uploading of images for avatars and document attachments an
# s3-compatible storage must be provided. AWS S3 is recommended for redundency
# however if you want to keep all file storage local an alternative such as 
# minio (https://github.com/minio/minio) can be used.

# A more detailed guide on setting up S3 is available here:
# => https://wiki.generaloutline.com/share/125de1cc-9ff6-424b-8415-0d58c809a40f
#
AWS_ACCESS_KEY_ID=get_a_key_from_aws
AWS_SECRET_ACCESS_KEY=get_the_secret_of_above_key
AWS_REGION=xx-xxxx-x
AWS_S3_UPLOAD_BUCKET_URL=http://s3:4569
AWS_S3_UPLOAD_MAX_SIZE=26214400

# # OPTIONAL AWS settings
AWS_S3_UPLOAD_BUCKET_NAME=
AWS_S3_FORCE_PATH_STYLE=false # Defaults to true
AWS_S3_ACL=private            # Defaults to private

# –––––––––––––– AUTHENTICATION ––––––––––––––

# Third party signin credentials, at least ONE OF EITHER Google, Slack,
# or Microsoft is required for a working installation or you'll have no sign-in
# options.

# To configure Slack auth, you'll need to create an Application at
# => https://api.slack.com/apps
#
# When configuring the Client ID, add these redirect URLs under "OAuth & Permissions":
# https://<URL>/auth/slack.callback
# https://<URL>/auth/slack.commands
SLACK_KEY=get_a_key_from_slack
SLACK_SECRET=get_the_secret_of_above_key

# To configure Google auth, you'll need to create an OAuth Client ID at
# => https://console.cloud.google.com/apis/credentials
#
# When configuring the Client ID, add an Authorized redirect URI:
# https://<URL>/auth/google.callback
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=

# To configure Microsoft/Azure auth, you'll need to create an OAuth Client. See 
# the guide for details on setting up your Azure App:
# => https://wiki.generaloutline.com/share/dfa77e56-d4d2-4b51-8ff8-84ea6608faa4
AZURE_CLIENT_ID= 
AZURE_CLIENT_SECRET=
AZURE_RESOURCE_APP_ID=



# –––––––––––––––– OPTIONAL ––––––––––––––––

# If using a Cloudfront/Cloudflare distribution or similar it can be set below.
# This will cause paths to javascript, stylesheets, and images to be updated to  
# the hostname defined in CDN_URL. In your CDN configuration the origin server 
# should be set to the same as URL.
CDN_URL=

# Auto-redirect to https in production. The default is true but you may set to 
# false if you can be sure that SSL is terminated at an external loadbalancer.
FORCE_HTTPS=true

# Have the installation check for updates by sending anonymized statistics to
# the maintainers
ENABLE_UPDATES=true

# Override the maxium size of document imports, could be required if you have
# especially large Word documents with embedded imagery
MAXIMUM_IMPORT_SIZE=5120000

# You may enable or disable debugging categories to increase the noisiness of
# logs. The default is a good balance
DEBUG=cache,presenters,events,emails,mailer,utils,multiplayer,server,services

# Comma separated list of domains to be allowed to signin to the wiki. If not
# set, all domains are allowed by default when using Google OAuth to signin
ALLOWED_DOMAINS=

# For a complete Slack integration with search and posting to channels the 
# following configs are also needed, some more details
# => https://wiki.generaloutline.com/share/be25efd1-b3ef-4450-b8e5-c4a4fc11e02a
#
SLACK_VERIFICATION_TOKEN=your_token
SLACK_APP_ID=A0XXXXXXX
SLACK_MESSAGE_ACTIONS=true

# Optionally enable google analytics to track pageviews in the knowledge base 
GOOGLE_ANALYTICS_ID=

# Optionally enable Sentry (sentry.io) to track errors and performance
SENTRY_DSN=

# To support sending outgoing transactional emails such as "document updated" or 
# "you've been invited" you'll need to provide authentication for an SMTP server
SMTP_HOST=
SMTP_PORT=
SMTP_USERNAME=
SMTP_PASSWORD=
SMTP_FROM_EMAIL=
SMTP_REPLY_EMAIL=

# Custom logo that displays on the authentication screen, scaled to height: 60px
# TEAM_LOGO=https://example.com/images/logo.png

# The default interface language. See translate.getoutline.com for a list of 
# available language codes and their rough percentage translated.
DEFAULT_LANGUAGE=en_US

echo "Setting $APP_DOMAIN env"

cloudron env set --app $APP_DOMAIN \
SECRET_KEY=$SECRET_KEY \
UTILS_SECRET=$UTILS_SECRET \
URL=$URL \
PORT=$PORT \
AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
AWS_REGION=$AWS_REGION \
AWS_S3_UPLOAD_BUCKET_URL=$AWS_S3_UPLOAD_BUCKET_URL \
AWS_S3_UPLOAD_BUCKET_NAME=$AWS_S3_UPLOAD_BUCKET_NAME \
AWS_S3_UPLOAD_MAX_SIZE=$AWS_S3_UPLOAD_MAX_SIZE \
AWS_S3_FORCE_PATH_STYLE=$AWS_S3_FORCE_PATH_STYLE \
AWS_S3_ACL=$AWS_S3_ACL \
SLACK_KEY=$SLACK_KEY \
SLACK_SECRET=$SLACK_SECRET \
GOOGLE_CLIENT_ID=$GOOGLE_CLIENT_ID \
GOOGLE_CLIENT_SECRET=$GOOGLE_CLIENT_SECRET \
AZURE_CLIENT_ID=$AZURE_CLIENT_ID \
AZURE_CLIENT_SECRET=$AZURE_CLIENT_SECRET \
AZURE_RESOURCE_APP_ID=$AZURE_RESOURCE_APP_ID \
CDN_URL=$CDN_URL \
FORCE_HTTPS=$FORCE_HTTPS \
ENABLE_UPDATES=$ENABLE_UPDATES \
MAXIMUM_IMPORT_SIZE=$MAXIMUM_IMPORT_SIZE \
DEBUG=$DEBUG \
ALLOWED_DOMAINS=$ALLOWED_DOMAINS \
SLACK_VERIFICATION_TOKEN=$SLACK_VERIFICATION_TOKEN \
SLACK_APP_ID=$SLACK_APP_ID \
SLACK_MESSAGE_ACTIONS=$SLACK_MESSAGE_ACTIONS \
GOOGLE_ANALYTICS_ID=$GOOGLE_ANALYTICS_ID \
SENTRY_DSN=$SENTRY_DSN \
SMTP_HOST=$SMTP_HOST \
SMTP_PORT=$SMTP_PORT \
SMTP_USERNAME=$SMTP_USERNAME \
SMTP_PASSWORD=$SMTP_PASSWORD \
SMTP_FROM_EMAIL=$SMTP_FROM_EMAIL \
SMTP_REPLY_EMAIL=$SMTP_REPLY_EMAIL \
DEFAULT_LANGUAGE=$DEFAULT_LANGUAGE

echo "Done"
echo "use `cloudron env list --app $APP` to check the app environment"