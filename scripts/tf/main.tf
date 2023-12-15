terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# See example.env for additional details
# Written against example.env at 32077cf1f8383c496951097d1667b7973b5a6191 (2023-12-13)
variable "TM_APP_BASE_URL" {
  type = string
  description = "Defines the URL of the frontend and is used by the backend for callbacks and emails"
}
variable "TM_APP_API_URL" {
  type = string
  description = "Defines the URL of the backend server. Used by both frontend and backend."
}
variable "TM_APP_API_VERSION" {
  type = string
  default = "v2"
  description = "Defines the version of the API and will be used after /api/ on the url"
}
variable "TM_ORG_NAME" {
  type = string
  description = "TM Organization name"
}
variable "TM_ORG_CODE" {
  type = string
  description = "Short code for the organization name"
}
variable "TM_ORG_URL" {
  type = string
  description = "Organization URL"
}
variable "TM_ORG_LOGO" {
  type = string
  description = "Logo to show the user for the organization"
  default = ""
}
variable "TM_ORG_PRIVACY_POLICY_URL" {
  type = string
  description = "Privacy policy URl"
}
variable "TM_ORG_TWITTER" {
  type = string
  description = "Twitter link"
}
variable "TM_ORG_FB" {
  type = string
  description = "Facebook link"
}
variable "TM_ORG_INSTAGRAM" {
  type = string
  description = "Instagram link"
}
variable "TM_ORG_YOUTUBE" {
  type = string
  description = "Youtube link"
}
variable "TM_ORG_GITHUB" {
  type = string
  description = "GitHub link"
}
variable "OSM_SERVER_URL" {
  type = string
  default = "https://www.openstreetmap.org"
  description = "OSM server URL"
}
variable "OSM_NOMINATIM_SERVER_URL" {
  type = string
  default = "https://nominatim.openstreetmap.org"
  description = "Nominatim server URL"
}
variable "OSM_REGISTER_URL" {
  type = string
  default = "https://www.openstreetmap.org/user/new"
  description = "New user link for openstreetmap servers, usually /user/new appended to osm_server_url"
}
variable "ID_EDITOR_URL" {
  type = string
  default = null
  description = "URL for the iD editor instance"
}
variable "POTLATCH2_EDITOR_URL" {
  type = string
  default = null
  description = "URL for the Potlatch2 editor instance"
}
variable "RAPID_EDITOR_URL" {
  type = string
  default = null
  description = "URL for the Rapid editor instance"
}
variable "TM_MATOMO_ID" {
  type = string
  default = null
  description = "Matomo id"
}
variable "TM_MATOMO_ENDPOINT" {
  type = string
  default = null
  description = "Matomo endpoint"
}
variable "TM_MAPBOX_TOKEN" {
  type = string
  default = null
  description = "Mapbox token for the default basemap"
}
variable "TM_ENABLE_SERVICEWORKER" {
  type = bool
  default = false
  description = "Register or unregister service workers"
}
variable "TM_IMAGE_UPLOAD_API_URL" {
  type = string
  default = null
  description = "Image upload URL"
}
variable "TM_IMAGE_UPLOAD_API_KEY" {
  type = string
  default = null
  description = "Image upload key"
}
variable "TM_HOMEPAGE_IMG_HIGH" {
  type = string
  default = null
  description = "High resolution image for the homepage banner"
}
variable "TM_HOMEPAGE_IMG_LOW" {
  type = string
  default = null
  description = "Low resolution image for the homepage banner"
}
variable "TM_HOMEPAGE_VIDEO_URL" {
  type = string
  default = null
  description = "Define a video to be played in the background of the homepage banner"
}
variable "OHSOME_STATS_BASE_URL" {
  type = string
  default = "https://stats.now.ohsome.org/api"
  description = "API URL for ohsomeNow Stats"
}
variable "OHSOME_STATS_TOKEN" {
  type = string
  default = null
  description = "API Token for ohsomeNow Stats"
}
variable "TM_SECRET" {
  type = string
  default = "s0m3l0ngr4nd0mstr1ng-b3cr34tiv3"
  description = "Used to give authorization to frontend/backend to communicate with one another"
}
variable "TM_CLIENT_ID" {
  type = string
  description = "OSM OAuth2 client id"
}
variable "TM_CLIENT_SECRET" {
  type = string
  description = "OSM OAuth2 secret"
}
variable "TM_REDIRECT_URI" {
  type = string
  description = "Redirect URI registered when creating OAuth2 application; typically TM_APP_BASE_URL/authorized"
}
variable "TM_SCOPE" {
  type = set(string)
  default = ["read_prefs", "write_api"]
  description = "Scope of TM defined while creating OAuth2 application"
}
variable "TM_DEFAULT_CHANGESET_COMMENT" {
  type = string
  description = "The default comment for a changeset, typically \"#$${nameofyourorganization}-project\""
}
variable "POSTGRES_DB" {
  type = string
  default = "tasking-manager"
}
variable "POSTGRES_USER" {
  type = string
  default = "tm"
}
variable "POSTGRES_PASSWORD" {
  type = string
}
variable "TM_EMAIL_FROM_ADDRESS" {
  type = string
  default = null
  description = "Required to send email (tasks validated, etc.)"
}
variable "TM_EMAIL_CONTACT_ADDRESS" {
  type = string
  default = null
  description = "Email used by the contact form"
}
variable "TM_SMTP_HOST" {
  type = string
  default = null
}
variable "TM_SMTP_PORT" {
  default = 25
  type = number
}
variable "TM_SMTP_USER" {
  type = string
  default = null
}
variable "TM_SMTP_USE_TLS" {
  type = bool
  default = false
}
variable "TM_SMTP_USE_SSL" {
  type = bool
  default = true
}
variable "TM_SEND_PROJECT_EMAIL_UPDATES" {
  type = bool
  default = true
}
variable "TM_SERVICE_DESK" {
  type = string
  default = null
  description = "Used for support requests, if configured"
}
variable "TM_LOG_LEVEL" {
  type = string
  default = "DEBUG"
  description = "Logging settings. See https://docs.python.org/3/library/logging.html#levels for other levels"
}
variable "TM_LOG_DIR" {
  type = string
  default = "/tmp/logs"
  description = "Logging directory"
}
variable "TM_DEFAULT_LOCALE" {
  type = string
  default = "en"
  description = "Default language for the TM"
}
variable "TM_SUPPORTED_LANGUAGES_CODES" {
  type = string
  default = null
  description = "Allowable languages on the TM"
}
variable "TM_SUPPORTED_LANGUAGES" {
  type = string
  default = null
  description = "Allowable languages in the TM"
}
variable "TM_TASK_AUTOUNLOCK_AFTER" {
  type = string
  default = null
  description = "Time to wait until task auto-unlock (e.g. '2h', '7d', '30m', '1h30m')"
}
variable "TM_MAPPER_LEVEL_INTERMEDIATE" {
  type = number
  default = null
  description = "Mapper Level values represent number of OSM changesets for intermediate mappers"
}
variable "TM_MAPPER_LEVEL_ADVANCED" {
  type = number
  default = null
  description = "Mapper Level values represent number of OSM changesets for advanced mappers"
}
variable "TM_IMPORT_MAX_FILESIZE" {
  type = number
  default = null
  description = "The file size limit to allow when importing project geometry from a file in bytes."
}
variable "TM_MAX_AOI_AREA" {
  type = number
  default = null
  description = "Maximum area in square kilometers for a projects' Area of Interest. The default is 5000."
}
variable "TM_SENTRY_BACKEND_DSN" {
  type = string
  default = null
}
variable "TM_SENTRY_FRONTEND_DSN" {
  type = string
  default = null
}
variable "admin_osm_id" {
  type = number
  description = "The OSM User id for the Admin User"
}

module "db" {
  source = "./db"
  POSTGRES_USER = var.POSTGRES_USER
  POSTGRES_PASSWORD = var.POSTGRES_PASSWORD
  POSTGRES_DB = var.POSTGRES_DB
  admin_osm_id = var.admin_osm_id
}

module "backend" {
  source = "./backend"
  TM_APP_BASE_URL = var.TM_APP_BASE_URL
  TM_APP_API_URL = var.TM_APP_API_URL
  TM_APP_API_VERSION = var.TM_APP_API_VERSION
  TM_ORG_NAME = var.TM_ORG_NAME
  TM_ORG_CODE = var.TM_ORG_CODE
  TM_ORG_LOGO = var.TM_ORG_LOGO
  OSM_SERVER_URL = var.OSM_SERVER_URL
  OSM_NOMINATIM_SERVER_URL = var.OSM_NOMINATIM_SERVER_URL
  TM_IMAGE_UPLOAD_API_URL = var.TM_IMAGE_UPLOAD_API_URL
  TM_IMAGE_UPLOAD_API_KEY = var.TM_IMAGE_UPLOAD_API_KEY
  TM_SECRET = var.TM_SECRET
  TM_CLIENT_ID = var.TM_CLIENT_ID
  TM_CLIENT_SECRET = var.TM_CLIENT_SECRET
  TM_REDIRECT_URI = var.TM_REDIRECT_URI
  TM_SCOPE = var.TM_SCOPE
  TM_DEFAULT_CHANGESET_COMMENT = var.TM_DEFAULT_CHANGESET_COMMENT
  POSTGRES_DB = var.POSTGRES_DB
  POSTGRES_USER = var.POSTGRES_USER
  POSTGRES_PASSWORD = var.POSTGRES_PASSWORD
  POSTGRES_ENDPOINT = module.db.db_host
  POSTGRES_DOCKER_NETWORK = module.db.db_network
  TM_EMAIL_FROM_ADDRESS = var.TM_EMAIL_FROM_ADDRESS
  TM_EMAIL_CONTACT_ADDRESS = var.TM_EMAIL_CONTACT_ADDRESS
  TM_SMTP_HOST = var.TM_SMTP_HOST
  TM_SMTP_PORT = var.TM_SMTP_PORT
  TM_SMTP_USER = var.TM_SMTP_USER
  TM_SMTP_USE_TLS = var.TM_SMTP_USE_TLS
  TM_SMTP_USE_SSL = var.TM_SMTP_USE_SSL
  TM_SEND_PROJECT_EMAIL_UPDATES = var.TM_SEND_PROJECT_EMAIL_UPDATES
  TM_LOG_LEVEL = var.TM_LOG_LEVEL
  TM_LOG_DIR = var.TM_LOG_DIR
  TM_SUPPORTED_LANGUAGES_CODES = var.TM_SUPPORTED_LANGUAGES_CODES
  TM_SUPPORTED_LANGUAGES = var.TM_SUPPORTED_LANGUAGES
  TM_TASK_AUTOUNLOCK_AFTER = var.TM_TASK_AUTOUNLOCK_AFTER
  TM_MAPPER_LEVEL_INTERMEDIATE = var.TM_MAPPER_LEVEL_INTERMEDIATE
  TM_MAPPER_LEVEL_ADVANCED = var.TM_MAPPER_LEVEL_ADVANCED
  TM_SENTRY_BACKEND_DSN = var.TM_SENTRY_BACKEND_DSN
}

module "frontend" {
  source = "./frontend"
  TM_APP_BASE_URL = var.TM_APP_BASE_URL
  TM_APP_API_URL = var.TM_APP_API_URL
  TM_APP_API_VERSION = var.TM_APP_API_VERSION
  TM_ORG_NAME = var.TM_ORG_NAME
  TM_ORG_CODE = var.TM_ORG_CODE
  TM_ORG_URL = var.TM_ORG_URL
  TM_ORG_LOGO = var.TM_ORG_LOGO
  TM_ORG_PRIVACY_POLICY_URL = var.TM_ORG_PRIVACY_POLICY_URL
  TM_ORG_TWITTER = var.TM_ORG_TWITTER
  TM_ORG_FB = var.TM_ORG_FB
  TM_ORG_INSTAGRAM = var.TM_ORG_INSTAGRAM
  TM_ORG_YOUTUBE = var.TM_ORG_YOUTUBE
  TM_ORG_GITHUB = var.TM_ORG_GITHUB
  OSM_SERVER_URL = var.OSM_SERVER_URL
  OSM_REGISTER_URL = var.OSM_REGISTER_URL #
  ID_EDITOR_URL = var.ID_EDITOR_URL
  POTLATCH2_EDITOR_URL = var.POTLATCH2_EDITOR_URL
  RAPID_EDITOR_URL = var.RAPID_EDITOR_URL
  TM_MATOMO_ID = var.TM_MATOMO_ID
  TM_MATOMO_ENDPOINT = var.TM_MATOMO_ENDPOINT
  TM_MAPBOX_TOKEN = var.TM_MAPBOX_TOKEN
  TM_ENABLE_SERVICEWORKER = var.TM_ENABLE_SERVICEWORKER
  TM_IMAGE_UPLOAD_API_URL = var.TM_IMAGE_UPLOAD_API_URL
  TM_IMAGE_UPLOAD_API_KEY = var.TM_IMAGE_UPLOAD_API_KEY
  TM_HOMEPAGE_IMG_HIGH = var.TM_HOMEPAGE_IMG_HIGH
  TM_HOMEPAGE_IMG_LOW = var.TM_HOMEPAGE_IMG_LOW
  TM_HOMEPAGE_VIDEO_URL = var.TM_HOMEPAGE_VIDEO_URL
  OHSOME_STATS_BASE_URL = var.OHSOME_STATS_BASE_URL
  OHSOME_STATS_TOKEN = var.OHSOME_STATS_TOKEN
  TM_SECRET = var.TM_SECRET
  TM_CLIENT_ID = var.TM_CLIENT_ID
  TM_CLIENT_SECRET = var.TM_CLIENT_SECRET
  TM_REDIRECT_URI = var.TM_REDIRECT_URI
  TM_SCOPE = var.TM_SCOPE
  TM_DEFAULT_CHANGESET_COMMENT = var.TM_DEFAULT_CHANGESET_COMMENT
  TM_EMAIL_CONTACT_ADDRESS = var.TM_EMAIL_CONTACT_ADDRESS
  TM_SERVICE_DESK = var.TM_SERVICE_DESK
  TM_DEFAULT_LOCALE = var.TM_DEFAULT_LOCALE
  TM_SUPPORTED_LANGUAGES_CODES = var.TM_SUPPORTED_LANGUAGES_CODES
  TM_SUPPORTED_LANGUAGES = var.TM_SUPPORTED_LANGUAGES
  TM_TASK_AUTOUNLOCK_AFTER = var.TM_TASK_AUTOUNLOCK_AFTER
  TM_MAPPER_LEVEL_INTERMEDIATE = var.TM_MAPPER_LEVEL_INTERMEDIATE
  TM_MAPPER_LEVEL_ADVANCED = var.TM_MAPPER_LEVEL_ADVANCED
  TM_IMPORT_MAX_FILESIZE = var.TM_IMPORT_MAX_FILESIZE
  TM_MAX_AOI_AREA = var.TM_MAX_AOI_AREA
  TM_SENTRY_FRONTEND_DSN = var.TM_SENTRY_FRONTEND_DSN
}