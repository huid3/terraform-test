resource "kubernetes_deployment" "nginx-example" {
  metadata {
    name = "nginx-example"

    labels = {
      maintained_by = "terraform"
      app           = "nginx-example"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "nginx-example"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx-example"
        }
      }
      spec {
        container {
          image = "nginx:latest"
          name  = "nginx-example-1"
        }
      }
    }

  }

  depends_on = [module.gke]
}

# resource "kubernetes_service" "nginx-example" {
#   metadata {
#     name = "nginx-example"
#   }

#   spec {
#     type = "LoadBalancer"
#     selector = {
#       app = kubernetes_deployment.nginx-example.metadata[0].labels.app
#     }

#     port {
#       port        = 80
#       target_port = 80
#     }
#   }

#   depends_on = [module.gke]
# }

# resource "kubernetes_service" "django" {
#   metadata {
#     name = "django"
#   }

#   spec {
#     selector = {
#       app = "django"
#     }

#     port {
#       name       = "http"
#       port       = 80
#       target_port = 8000
#     }

#     type = "ClusterIP"
#   }
# }


resource "kubernetes_service" "nginx" {
  metadata {
    name = "nginx-ingress"
  }
  spec {
    selector = {
      "app" = kubernetes_deployment.nginx-example.metadata[0].labels.app
    }
    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }
    type = "NodePort"
  }
  depends_on = [module.gke]
}

# resource "kubernetes_ingress" "nginx" {
#   wait_for_load_balancer = true
#   metadata {
#     name = "nginx-ingress"
#     annotations = {
#       "kubernetes.io/ingress.class" = "nginx"
#     }
#   }
#   spec {
#     rule {
#       http {
#         path {
#           path = "/*"
#           backend {
#             service_name = kubernetes_service.nginx.metadata.0.name
#             service_port = 80
#           }
#         }
#       }
#     }
#   }
#   depends_on = [module.gke]
# }