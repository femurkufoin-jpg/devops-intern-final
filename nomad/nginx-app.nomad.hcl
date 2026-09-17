variable "image" {
  type = string
}

job "devops-intern-app" {
  datacenters = ["dc1"]
  type = "service"

  group "web" {
    count = 1

    update {
      max_parallel      = 1
      min_healthy_time  = "10s"
      healthy_deadline  = "5m"
      progress_deadline = "10m"
      auto_revert       = true
      auto_promote      = false
    }

    network {
      port "http" {
        static = 8080
        to     = 8080
      }
    }

    task "nginx" {
      driver = "docker"

      config {
        image = var.image
        ports = ["http"]
      }

      resources {
        cpu    = 100
        memory = 128
      }

      service {
        name     = "devops-intern-nginx"
        provider = "nomad"
        port     = "http"

        check {
          type     = "http"
          path     = "/healthz"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
