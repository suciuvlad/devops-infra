job "nomad-ui" {
  datacenters = ["my_datacenter"]

  group "group" {
    count = 1

    network {
      mode = "bridge"
      port "http" {
        to     = 4646  # Port number where the Nomad UI is served.
      }
    }

    service {
      name = "nomad-ui"
      port = "http"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.nomad-ui.rule=Host(`nomad.purposeinplay.com`)",  # Change this hostname as necessary.
        "traefik.http.services.nomad-ui.loadbalancer.server.port=4646"  # Port number where the Nomad UI is served.
      ]

      check {
        name     = "alive"
        type     = "http"
        path     = "/ui"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "nomad-ui" {
      driver = "raw_exec"  # It's using the raw_exec driver which doesn't run inside a container

      config {
        command = "/bin/sh"
        args = ["-c", "sleep infinity"]  # A dummy task that doesn't do anything and doesn't exit
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}