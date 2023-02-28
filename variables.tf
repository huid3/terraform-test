variable "project_id" {}
variable "credentials_file" {}
variable "region" {
  default = "us-central1"
}
variable "compute_engine_service_account" {
  description = "Service account to associate to the nodes in the cluster"
  default     = "365358090-compute@developer.gserviceaccount.com"
}
variable "vpc_name" {
  default = "vpc-test-network"
}
variable "ip_range_pods_name" {
  default = "ip-range-pods"
}
variable "ip_range_services_name" {
  default = "ip-range-services"
}
variable "subnetwork" {
  default = "gke-subnet"
}
