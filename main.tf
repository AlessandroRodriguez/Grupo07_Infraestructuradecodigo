terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"  # Se indica que se usará el proveedor "docker"
      version = "3.6.2"               # Versión específica del proveedor
    }
  }
}

provider "docker" {
  # Configuración por defecto, asume Docker local
  # Por omisión, se conecta al Docker local (unix socket)

}

resource "docker_container" "web_server" {
  name  = "redis"                     # Nombre del contenedor Docker
  image = "redis:8.2.0-bookworm"      # Imagen utilizada (Redis versión 8.2.0)

  ports {
    internal = 6379                   # Puerto interno que usa Redis por defecto
    external = 32768                  # Puerto externo mapeado en el host
  }
}

output "redis_host_port" {
  description = "Puerto externo asignado automáticamente por Docker"
  value       = docker_container.web_server.ports[0].external
  # Exporta el puerto externo, útil para conectarse al servicio desde fuera
}
