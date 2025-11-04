terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Construye la imagen de la app desde ./src
resource "docker_image" "ai_app" {
  name         = "ai_app:latest"
  build {
    context    = "${path.module}/../src"
  }
}

# Contenedor de la app Flask
resource "docker_container" "ai_app" {
  name  = "ai_app"
  image = docker_image.ai_app.name
  ports {
    internal = 5000
    external = 5000
  }
}

# Contenedor de Prometheus
resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = "prom/prometheus:latest"
  ports {
    internal = 9090
    external = 9090
  }
  # CORRECCIÓN: Usar bloque 'volumes'
  volumes {
    # Usar abspath() para convertir la ruta relativa a absoluta
    host_path      = abspath("${path.module}/../prometheus/prometheus.yml") 
    container_path = "/etc/prometheus/prometheus.yml"
  }
}

# Contenedor de Grafana
resource "docker_container" "grafana" {
  name  = "grafana"
  image = "grafana/grafana:latest"
  ports {
    internal = 3000
    external = 3000
  }
  # CORRECCIÓN: Usar bloque 'volumes'
 #volumes {
    # Usar abspath() para convertir la ruta relativa a absoluta
   #host_path      = abspath("${path.module}/../grafana")
   #container_path = "/etc/grafana"
  #}
}
