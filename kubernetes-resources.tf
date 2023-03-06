# resource "kubernetes_deployment" "nginx-example" {
#   metadata {
#     name = "nginx-example"

#     labels = {
#       maintained_by = "terraform"
#       app           = "nginx-example"
#     }
#   }

#   spec {
#     replicas = 1
#     selector {
#       match_labels = {
#         app = "nginx-example"
#       }
#     }
#     template {
#       metadata {
#         labels = {
#           app = "nginx-example"
#         }
#       }
#       spec {
#         container {
#           image = "nginx:latest"
#           name  = "nginx-example-1"
#         }
#       }
#     }

#   }

#   depends_on = [module.gke]
# }

# resource "kubernetes_service" "nginx" {
#   metadata {
#     name = "nginx-lb-test"
#     annotations = {
#       "cloud.google.com/load-balancer-type" : "Internal"
#     }
#   }
#   spec {
#     selector = {
#       app = kubernetes_deployment.nginx-example.metadata.0.labels.app
#     }
#     port {
#       port        = 80
#       target_port = 80
#     }
#     type = "LoadBalancer"
#   }
#   depends_on = [module.gke]
# }

resource "kubernetes_service" "neg_test" {
  metadata {
    name = "django-test-neg"
    labels = {
      app = "django-test"
    }
    annotations = {
      "cloud.google.com/neg" = "{ \"ingress\" : true }"
    }
  }

  spec {
    port {
      name        = "http"
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }
    selector = {
      app = "django-test"
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_deployment" "dummy_test" {
  metadata {
    name = "django-test"
    labels = {
      app = "django-test"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "django-test"
      }
    }
    template {
      metadata {
        labels = {
          app = "django-test"
        }
      }

      spec {
        container {
          name = "django-test"
          env {
            name  = "LISTEN_ADDR"
            value = "0.0.0.0:8080"
          }
          env {
            name  = "SERVER_TYPE"
            value = "http"
          }
          env {
            name  = "NAME"
            value = "web"
          }
          env {
            name  = "MESSAGE"
            value = "Response from web"
          }
          env {
            name = "KUBERNETES_NAMESPACE"
            value_from {
              field_ref {
                field_path = "metadata.namespace"
              }
            }
          }
          image             = "nicholasjackson/fake-service:v0.22.9"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = 8080
            name           = "http"
            protocol       = "TCP"
          }
          security_context {
            privileged = false
          }
        }
      }
    }
  }
}

# resource "kubernetes_ingress" "dummy_ingress" {
#   metadata {
#     name = "example-ingress"
#   }

#   spec {
#     backend {
#       service_name = "myapp-1"
#       service_port = 8080
#     }

#     rule {
#       http {
#         path {
#           backend {
#             service_name = "myapp-1"
#             service_port = 8080
#           }

#           path = "/app1/*"
#         }

#         path {
#           backend {
#             service_name = "myapp-2"
#             service_port = 8080
#           }

#           path = "/app2/*"
#         }
#       }
#     }

#     tls {
#       secret_name = "tls-secret"
#     }
#   }
# }
