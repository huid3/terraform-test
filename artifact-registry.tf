resource "google_artifact_registry_repository" "terraform-test" {
  location      = "us-central1"
  repository_id = "terraform-test"
  description   = "example docker repository"
  format        = "DOCKER"
}