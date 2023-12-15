terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

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
variable "TM_EMAIL_CONTACT_ADDRESS" {
  type = string
  default = null
  description = "Email used by the contact form"
}
variable "TM_SERVICE_DESK" {
  type = string
  default = null
  description = "Used for support requests, if configured"
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
variable "TM_SENTRY_FRONTEND_DSN" {
  type = string
  default = null
}

data "docker_registry_image" "node" {
  name = "node:16"
}
data "docker_registry_image" "nginx" {
  name = "nginx:stable-alpine"
}

resource "docker_image" "frontend" {
  name = "frontend"
  build {
    context = "${path.cwd}/../../"
    tag = ["hot/tasking-manager/frontend:latest"]
    dockerfile = "scripts/docker/Dockerfile.frontend"
    label = {
      author: "HOTOSM (TM) and Meta (TF)"
    }
  }
  // These triggers are copied from the Dockerfile
  triggers = {
    image_nginx_sha = data.docker_registry_image.nginx.sha256_digest
    image_node_sha = data.docker_registry_image.node.sha256_digest
    dir_frontend_sha = sha1(join("", [for f in fileset(path.module, "../../frontend/*") : filesha1(f)]))
    dir_frontend_src_sha = sha1(join("", [for f in fileset(path.module, "../docker/*") : filesha1(f)]))
    dir_root = sha1(join("", [for f in fileset(path.module, "../../*") : filesha1(f)]))
    env_sha = sha1(join("", [var.TM_APP_API_URL, var.TM_APP_API_VERSION, var.TM_CLIENT_SECRET, var.TM_SECRET, var.TM_CLIENT_ID]))
  }
}

resource "docker_container" "frontend" {
  name = "frontend"
  image = docker_image.frontend.image_id
  ports {
    internal = 80
    external = 80
  }
}