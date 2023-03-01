variable "project_id" {}
variable "region" {
  default = "us-central1"
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