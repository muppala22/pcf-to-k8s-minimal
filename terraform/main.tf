terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_config_map" "app_config" {
  metadata {
    name = "pcf-to-k8s-config"
  }

  data = {
    APP_MESSAGE = "Configured via ConfigMap"
  }
}

resource "kubernetes_deployment" "app" {
  metadata {
    name = "pcf-to-k8s"
    labels = {
      app = "pcf-to-k8s"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "pcf-to-k8s"
      }
    }

    template {
      metadata {
        labels = {
          app = "pcf-to-k8s"
        }
      }

      spec {
        container {
          name  = "app"
          image = "pcf-to-k8s-demo"
          image_pull_policy = "Never"

          port {
            container_port = 8080
          }

          env {
            name = "APP_MESSAGE"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.app_config.metadata[0].name
                key  = "APP_MESSAGE"
              }
            }
          }

          liveness_probe {
            http_get {
              path = "/actuator/health"
              port = 8080
            }
            initial_delay_seconds = 10
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = 8080
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
        }
      }
    }

    strategy {
      type = "RollingUpdate"
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = "pcf-to-k8s"
  }

  spec {
    selector = {
      app = kubernetes_deployment.app.metadata[0].labels.app
    }

    port {
      port        = 8080
      target_port = 8080
    }
  }
}
