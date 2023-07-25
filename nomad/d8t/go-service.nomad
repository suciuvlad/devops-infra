job "go-service" {
  datacenters = ["my_datacenter"]

  group "group" {
    count = 1

    network {
      mode = "bridge"
      port "http" {
        static = 80
        to     = 8080
      }
    }

    service {
      name = "my-go-app"
      port = "http"

      // Traefik Labels
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.my-app.rule=Host(`traefik.purposeinplay.com`)",
        "traefik.http.services.my-app.loadbalancer.server.port=8080"
      ]

      connect {
        sidecar_service {}
      }

      check {
        name     = "alive"
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "server" {
      driver = "docker"

      config {
        image = "ghcr.io/suciuvlad/my-go-app:latest"
      }

      resources {
        cpu    = 500
        memory = 256
      }
    }
  }
}