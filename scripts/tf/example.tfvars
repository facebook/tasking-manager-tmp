# Tasking Manager configuration file

# Copy to `terraform.tfvars` and adjust to make it work!
#

# The TM_APP_BASE_URL defines the URL of the frontend and is used by the backend
# to configure links on emails and some authentication callbacks.
# On development instances it should be 127.0.0.1:3000 or localhost:3000
# On production instances, use the public URL of your frontend
# TM_APP_BASE_URL=https://tasks.hotosm.org
TM_APP_BASE_URL="http://127.0.0.1:3000"

# The TM_APP_API_URL defines the URL of your backend server. It will be used by
# both the backend and by the frontend
# On development instances it should be 127.0.0.1:5000 or localhost:5000
# On production instances, use the public URL of your backend
TM_APP_API_URL="http://127.0.0.1:5000"

# Defines the version of the API and will be used after /api/ on the url
TM_APP_API_VERSION="v2"

# Information about the hosting organization
TM_ORG_NAME="Humanitarian OpenStreetMap Team"
TM_ORG_CODE="HOT"
TM_ORG_LOGO="https://cdn.img.url/logo.png"
# Don't use http or https on the following two variables
TM_ORG_URL="example.com"
TM_ORG_PRIVACY_POLICY_URL="https://www.hotosm.org/privacy"
TM_ORG_TWITTER="https://twitter.com/hotosm"
TM_ORG_FB="https://www.facebook.com/hotosm"
TM_ORG_INSTAGRAM="https://www.instagram.com/open.mapping.hubs/"
TM_ORG_YOUTUBE="https://www.youtube.com/user/hotosm"
TM_ORG_GITHUB="https://github.com/hotosm"

# Information about the OSM server - Customize your server here
# By default, it's the public OpenStreetMap.org server
OSM_SERVER_URL="https://www.openstreetmap.org"
OSM_NOMINATIM_SERVER_URL="https://nominatim.openstreetmap.org"
OSM_REGISTER_URL="https://www.openstreetmap.org/user/new"

# Information about the Editor URLs. Those are the default values on the frontend.
# You only need to modify it in case you want to direct users to map on a different OSM instance.
# ID_EDITOR_URL="https://www.openstreetmap.org/edit?editor=id&"
# POTLATCH2_EDITOR_URL="https://www.openstreetmap.org/edit?editor=potlatch2"
# RAPID_EDITOR_URL="https://mapwith.ai/rapid"

# Matomo configuration. Optional, configure it in case you have a Matomo instance.
# TM_MATOMO_ID="site_id"
# TM_MATOMO_ENDPOINT="https://..."

# Mapbox access key to display the maps (optional)
#
# In order to use the default basemap, you’ll need to set a
# Mapbox token (https://docs.mapbox.com/help/glossary/access-token) from your Mapbox account.
# Costs apply to usage of Mapbox maps above 50,000 map loads per month; if you’d like to ask for
# account support to cover those costs, contact Mapbox Community https://mapbox.com/community.
#
# If you do not set a token, then maps will fallback to using the raster tile based
# Humanitarian Layer.
#
# TM_MAPBOX_TOKEN=

# If you want your TM app to work better offline and load faster, you can change
# from 0 (unregister) to 1 (register) below. Note this comes with some pitfalls.
# Learn more about service workers: https://bit.ly/CRA-PWA
# It is more complex to use for TM if your frontend and backend are on same server.
# TM_ENABLE_SERVICEWORKER=false

# Define an API URL and KEY of an image upload service.
# It will be used to store the Organisation logos and the images uploaded on comments input fields.
# HOT uses this service: https://github.com/hotosm/cdn-upload-api/ to setup an image upload API
# TM_IMAGE_UPLOAD_API_URL=
# TM_IMAGE_UPLOAD_API_KEY=

# Define the image to be used on the homepage main's banner.
# If it's not defined, the default images will be used.
# The high resolution image should be 2500px width. The low should be 824px.
# TM_HOMEPAGE_IMG_HIGH="https://cdn.img.url/banner-high.png"
# TM_HOMEPAGE_IMG_LOW="https://cdn.img.url/banner-low.png"

# Define a video to be played on the background of the homepage's main banner.
# On HOT instance we use https://cdn.hotosm.org/tasking-manager/mapping.mp4
# Please copy it to your CDN / server in order to avoid overloading the HOT CDN.
# It's not required to set this tag. Case it isn't set, an image will be used as background.
# TM_HOMEPAGE_VIDEO_URL=

# API base URL and token(used to retrieve user stats only) for ohsomeNow Stats
#
OHSOME_STATS_BASE_URL="https://stats.now.ohsome.org/api"
OHSOME_STATS_TOKEN="testSuperSecretTestToken"

# Secret (required)
#
# A freely definable secret. Gives authorization to the front- and and back-end
# to talk to each other.
#
TM_SECRET="s0m3l0ngr4nd0mstr1ng-b3cr34tiv3"

# OpenStreetMap OAuth2 client id and secret (required)
#
TM_CLIENT_ID="foo"
TM_CLIENT_SECRET="s0m3l0ngr4nd0mstr1ng-b3cr34tiv3"

# Redirect uri registered while creating OAuth2 application (required)
TM_REDIRECT_URI="http://127.0.0.1:3000/authorized"

# Scope of TM defined while creating OAuth2 application (required)
TM_SCOPE=["read_prefs", "write_api"]

# Required by requests_oauthlib to work while making oauth2 requests from http server (required)
# OAUTHLIB_INSECURE_TRANSPORT = true

# The default tag used in the OSM changeset comment
# IMPORTANT! This must be unique on your instance
#
# TM_DEFAULT_CHANGESET_COMMENT="#{nameofyourorganisation}-project"

####################################################
#
#          DATABASE CONNECTION PARAMETERS
#
####################################################
# The connection to the postgres database (required)
POSTGRES_DB="tasking-manager"
POSTGRES_USER="tm"
POSTGRES_PASSWORD="tm"
# POSTGRES_ENDPOINT="localhost"
# POSTGRES_PORT=5432

# The OSM user id of the admin user. Don't know what your user id is? See http://whosthat.osmz.ru/ .
# This is the numeric id; do not prepend a `#` character.
# admin_osm_id=0

# The postgres database name used for testing (required).
# All other configurations except the database name are inherited from the main database defined above.
# POSTGRES_TEST_DB="tasking-manager-test"

# The address to use as the sender on auto generated emails
# (optional, but required to send email)
#
# TM_EMAIL_FROM_ADDRESS="noreply@localhost"

# The address to use as the receiver in contact form.
#
# TM_EMAIL_CONTACT_ADDRESS="sysadmin@localhost"

# Email sending server configuration (optional)
# This is required in order to send out messages.
#
# TM_SMTP_HOST=
# TM_SMTP_PORT=25
# TM_SMTP_USER=
# TM_SMTP_PASSWORD=
# Following two variables can have value of either 0 or 1
# TM_SMTP_USE_TLS=0
# TM_SMTP_USE_SSL=1

# If disabled project update emails will not be sent. 
# Set it disabled in case of testing instances
TM_SEND_PROJECT_EMAIL_UPDATES = false

# TM_SERVICE_DESK
# If the organisation has a service desk, configures the link
# in the Contact page and Fallback Component to point to it
# TM_SERVICE_DESK

# Logging settings  (optional)
# (e.g. ERROR, DEBUG, etc.)
# If not specified DEBUG is default. ERROR is a good value for a live site.
#
# TM_LOG_LEVEL=DEBUG
# TM_LOG_DIR=logs

# Languages settings for the Tasking Manager
#
TM_DEFAULT_LOCALE="en"

# By default all available languages are shown. You can restrict languages by modifying the following two variables.
# Please note that there must be exactly the same number of codes as languages.
#
# TM_SUPPORTED_LANGUAGES_CODES="ar, cs, de, el, en, es, fa_IR, fr, he, hu, id, it, ja, ko, mg, ml, nl_NL, pt, pt_BR, ru, sv, sw, tl, tr, uk, zh_TW"
# TM_SUPPORTED_LANGUAGES="عربى, Čeština, Deutsch, Ελληνικά, English, Español, فارسی, Français, עברית, Magyar, Indonesia, Italiano, 日本語, 한국어, Malagasy, Malayalam, Nederlands, Português, Português (Brasil), Русский язык, Svenska, Kiswahili, Filipino (Tagalog), Türkçe, Українська, 繁體中文"

# Time to wait until task auto-unlock (optional)
# (e.g. '2h' or '7d' or '30m' or '1h30m')
#
# TM_TASK_AUTOUNLOCK_AFTER="2h"

# Mapper Level values represent number of OSM changesets (optional)
#
# TM_MAPPER_LEVEL_INTERMEDIATE=250
# TM_MAPPER_LEVEL_ADVANCED=500

# This sets a file size limit to allow when importing a project geometry from a file. Define it in bytes.
# TM_IMPORT_MAX_FILESIZE=1000000
# Defines the maximum area allowed to the Projects' AoI. Default is 5000. The unit is square kilometers.
# TM_MAX_AOI_AREA=5000

# Sentry.io DSN Config (optional)
# TM_SENTRY_BACKEND_DSN="https://foo.ingest.sentry.io/1234567"
# TM_SENTRY_FRONTEND_DSN="https://bar.ingest.sentry.io/8901234"
