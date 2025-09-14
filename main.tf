terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"
    }
  }
}

provider "docker" {
  # Configuración por defecto, asume Docker local
}

resource "docker_container" "web_server" {
  name  = "redis"
  image = "redis:8.2.0-bookworm"

  ports {
    internal = 6379
    external = 32768
  }
}

output "redis_host_port" {
  description = "Puerto externo asignado automáticamente por Docker"
  value       = docker_container.web_server.ports[0].external
}