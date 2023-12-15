terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

variable "POSTGRES_DB" {
  type = string
}
variable "POSTGRES_USER" {
  type = string
}
variable "POSTGRES_PASSWORD" {
  type = string
}
variable "admin_osm_id" {
  type = number
  description = "The OSM User id for the Admin User"
}

data "docker_registry_image" "postgis" {
  name = "postgis/postgis:latest"
}

resource "docker_image" "db_image" {
  name = data.docker_registry_image.postgis.name
  pull_triggers = [data.docker_registry_image.postgis.sha256_digest]
}

resource "docker_volume" "db_volume" {
  name = "db_volume"
}

resource "docker_network" "db_network" {
  name = "db_network"
}

resource "docker_container" "db_container" {
  image = docker_image.db_image.image_id
  name  = "db"
  ports {
    internal = 5432
    external = 5432
  }
  env = [
    "POSTGRES_USER=${var.POSTGRES_USER}",
    "POSTGRES_PASSWORD=${var.POSTGRES_PASSWORD}",
    "POSTGRES_DB=${var.POSTGRES_DB}",
  ]
  networks_advanced {
    name = docker_network.db_network.name
  }
}

resource "docker_container" "db_set_admin" {
  image = docker_image.db_image.image_id
  name = "db_set_admin"
  command = ["sh", "-c", "set -ex; export PGPASSWORD=${var.POSTGRES_PASSWORD}; while [ $(psql --username=${var.POSTGRES_USER} --host=${docker_container.db_container.hostname} --dbname=${var.POSTGRES_DB} --command='SELECT id FROM users WHERE id=${var.admin_osm_id};' | wc -l) -lt 5 ]; do sleep 5; done; psql --username=${var.POSTGRES_USER} --host=${docker_container.db_container.hostname} --dbname=${var.POSTGRES_DB} --command='UPDATE users SET role=1 WHERE id=${var.admin_osm_id}'"]
  must_run = false
  rm = false
  networks_advanced {
    name = docker_network.db_network.name
  }
}

output "db_host" {
  value = docker_container.db_container.hostname
}

output "db_network" {
  value = docker_network.db_network.name
}