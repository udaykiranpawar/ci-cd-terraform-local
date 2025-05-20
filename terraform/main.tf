terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "web_app" {
  name = "my-nginx-app"
  build {
    context    = "${path.module}/../app"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "web_container" {
  name  = "nginx-container"
  image = docker_image.web_app.name
  ports {
    internal = 80
    external = 8081  # Change this to an unused port, e.g., 8081
  }
}

