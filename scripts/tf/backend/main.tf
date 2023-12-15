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
variable "TM_ORG_LOGO" {
  type = string
  description = "Logo to show the user for the organization"
  default = ""
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
variable "POSTGRES_ENDPOINT" {
  type = string
  description = "Postgres endpoint"
}
variable "POSTGRES_PORT" {
  type = number
  default = 5432
  description = "Postgres port"
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
variable "TM_SENTRY_BACKEND_DSN" {
  type = string
  default = null
}
variable "POSTGRES_DOCKER_NETWORK" {
  type = string
  default = null
}

data "docker_registry_image" "python" {
  name = "python:3.10-slim-bookworm"
}

resource "docker_image" "backend" {
  name = "backend"
  build {
    context = "${path.cwd}/../../"
    tag = ["hot/tasking-manager/backend:latest"]
    label = {
      author: "HOTOSM (TM) and Meta (TF)"
    }
  }
  // These triggers are all copied from the Dockerfile
  triggers = {
    image_sha = data.docker_registry_image.python.sha256_digest
    dir_backend_sha1 = sha1(join("", [for f in fileset(path.module, "../../backend/*") : filesha1(f)]))
    dir_migrations_sha1 = sha1(join("", [for f in fileset(path.module, "../../migrations/*") : filesha1(f)]))
    dir_scripts_world = sha1(join("", [for f in fileset(path.module, "../world/*") : filesha1(f)]))
    dir_scripts_database = sha1(join("", [for f in fileset(path.module, "../database/*") : filesha1(f)]))
    tm_env = filesha1("../../tasking-manager.env")
  }
}

locals {
  env = compact([
    "TM_APP_BASE_URL=${var.TM_APP_BASE_URL}",
    "TM_APP_API_URL=${var.TM_APP_API_URL}",
    "TM_APP_API_VERSION=${var.TM_APP_API_VERSION}",
    var.TM_ORG_NAME != null ? "TM_ORG_NAME=${var.TM_ORG_NAME}" : "",
    var.TM_ORG_CODE != null ? "TM_ORG_CODE=${var.TM_ORG_CODE}" : "",
    var.OSM_SERVER_URL != null ? "OSM_SERVER_URL=${var.OSM_SERVER_URL}" : "",
    var.OSM_NOMINATIM_SERVER_URL != null ? "OSM_NOMINATIM_SERVER_URL=${var.OSM_NOMINATIM_SERVER_URL}" : "",
    var.TM_IMAGE_UPLOAD_API_URL != null ? "TM_IMAGE_UPLOAD_API_URL=${var.TM_IMAGE_UPLOAD_API_URL}" : "",
    var.TM_IMAGE_UPLOAD_API_KEY != null ? "TM_IMAGE_UPLOAD_API_KEY=${var.TM_IMAGE_UPLOAD_API_KEY}" : "",
    "TM_SECRET=${var.TM_SECRET}",
    "TM_CLIENT_ID=${var.TM_CLIENT_ID}",
    "TM_REDIRECT_URI=${var.TM_REDIRECT_URI}",
    var.TM_SCOPE != null ? "TM_SCOPE=${join(" ", var.TM_SCOPE)}" : "",
    "TM_DEFAULT_CHANGESET_COMMENT=${var.TM_DEFAULT_CHANGESET_COMMENT}",
    var.TM_EMAIL_FROM_ADDRESS != null ? "TM_EMAIL_FROM_ADDRESS=${var.TM_EMAIL_FROM_ADDRESS}" : "",
    var.TM_EMAIL_CONTACT_ADDRESS != null ? "TM_EMAIL_CONTACT_ADDRESS=${var.TM_EMAIL_CONTACT_ADDRESS}" : "",
    var.TM_SMTP_HOST != null ? "TM_SMTP_HOST=${var.TM_SMTP_HOST}" : "",
    var.TM_SMTP_PORT != null ? "TM_SMTP_PORT=${var.TM_SMTP_PORT}" : "",
    var.TM_SMTP_USER != null ? "TM_SMTP_USER=${var.TM_SMTP_USER}" : "",
    var.TM_SMTP_USE_TLS != null ? "TM_SMTP_USE_TLS=${var.TM_SMTP_USE_TLS ? 1 : 0}" : "",
    var.TM_SMTP_USE_SSL != null ? "TM_SMTP_USE_SSL=${var.TM_SMTP_USE_SSL ? 1 : 0}" : "",
    var.TM_SEND_PROJECT_EMAIL_UPDATES != null ? "TM_SEND_PROJECT_EMAIL_UPDATES=${var.TM_SEND_PROJECT_EMAIL_UPDATES ? 1 : 0}" : "",
    "TM_LOG_LEVEL=${var.TM_LOG_LEVEL}",
    "TM_LOG_DIR=${var.TM_LOG_DIR}",
    var.TM_SUPPORTED_LANGUAGES_CODES != null ? "TM_SUPPORTED_LANGUAGES_CODES=${var.TM_SUPPORTED_LANGUAGES_CODES}" : "",
    var.TM_SUPPORTED_LANGUAGES != null ? "TM_SUPPORTED_LANGUAGES=${var.TM_SUPPORTED_LANGUAGES}" : "",
    var.TM_TASK_AUTOUNLOCK_AFTER != null ? "TM_TASK_AUTOUNLOCK_AFTER=${var.TM_TASK_AUTOUNLOCK_AFTER}" : "",
    var.TM_MAPPER_LEVEL_INTERMEDIATE != null ? "TM_MAPPER_LEVEL_INTERMEDIATE=${var.TM_MAPPER_LEVEL_INTERMEDIATE}" : "",
    var.TM_MAPPER_LEVEL_ADVANCED != null ? "TM_MAPPER_LEVEL_ADVANCED=${var.TM_MAPPER_LEVEL_ADVANCED}" : "",
    var.TM_SENTRY_BACKEND_DSN != null ? "TM_SENTRY_BACKEND_DSN=${var.TM_SENTRY_BACKEND_DSN}" : "",
    "POSTGRES_ENDPOINT=${var.POSTGRES_ENDPOINT}",
    "POSTGRES_PORT=${var.POSTGRES_PORT}",
    "POSTGRES_USER=${var.POSTGRES_USER}",
    "POSTGRES_DB=${var.POSTGRES_DB}",
    "POSTGRES_PASSWORD=${var.POSTGRES_PASSWORD}",
    "TM_CLIENT_SECRET=${var.TM_CLIENT_SECRET}",
  ])
}

resource "docker_container" "migration" {
  image = docker_image.backend.image_id
  name = "migration"
  command = ["flask", "--app", "manage.py", "db", "upgrade"]
  must_run = false
  rm = true
  env = local.env
  networks_advanced {
    name = var.POSTGRES_DOCKER_NETWORK
  }
}

resource "docker_container" "backend" {
  depends_on = [docker_container.migration]
  image = docker_image.backend.image_id
  name = "backend"
  ports {
    internal = 5000
    external = 5000
  }
  healthcheck {
    test = ["curl", "-f", "http://localhost:8000/api/v2/system/heartbeat/", "||", "exit", "1"]
  }
  env = local.env
  networks_advanced {
    name = var.POSTGRES_DOCKER_NETWORK
  }
}
