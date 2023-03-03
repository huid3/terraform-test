# resource "kubernetes_deployment" "django" {
#   metadata {
#     name = "django-test"

#     labels = {
#       maintained_by = "terraform"
#       app           = "django-test"
#     }

#     spec {
#       replicas = 1
#       selector {
#         match_labels = {
#           app = "django-test"
#         }
#       }
#       template {
#         metadata {
#           labels = {
#             app = "django-test"
#           }
#         }
#         spec {
#           container {
#             image = ""
#             name  = "django-test-1"
#           }
#         }
#       }

#     }

#     depends_on = [module.gke]
#   }
# }
