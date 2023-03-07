# module "gcp-network" {
#   source  = "terraform-google-modules/network/google"
#   version = "~> 6.0"

#   project_id   = var.project_id
#   network_name = var.vpc_name

#   subnets = [
#     {
#       subnet_name   = var.subnetwork
#       subnet_ip     = "10.0.0.0/17"
#       subnet_region = var.region
#     },
#   ]

#   secondary_ranges = {
#     (var.subnetwork) = [
#       {
#         range_name    = var.ip_range_pods_name
#         ip_cidr_range = "192.168.0.0/18"
#       },
#       {
#         range_name    = var.ip_range_services_name
#         ip_cidr_range = "192.168.64.0/18"
#       },
#     ]
#   }
# }

resource "google_compute_network" "vpc_test_2" {
  name                    = "vpc-test-2"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "vpc-test-2-private-subnet"
  ip_cidr_range = "10.160.104.0/21"
  network       = google_compute_network.vpc_test_2.id
  region        = var.region

  secondary_ip_range = [{
    ip_cidr_range = "10.242.128.0/17"
    range_name    = var.ip_range_pods_name
    },
    {
      ip_cidr_range = "10.243.0.0/22"
      range_name    = var.ip_range_services_name
    }
  ]
}

resource "google_compute_subnetwork" "proxy_only_subnet" {
  name          = "vpc-test-2-proxy-only-subnet"
  ip_cidr_range = "11.129.0.0/23"
  network       = google_compute_network.vpc_test_2.id
  region        = var.region
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
}

# resource "google_compute_firewall" "allow-http" {
#   name    = "vpc-test-2-fw-allow-http"
#   network = google_compute_network.vpc_test_2.name
#   allow {
#     protocol = "tcp"
#     ports    = ["80"]
#   }
#   target_tags = ["http"]
# }

# resource "google_compute_firewall" "allow-internal" {
#   name    = "vpc-test-2-fw-allow-internal"
#   network = google_compute_network.vpc_test_2.name
#   allow {
#     protocol = "icmp"
#   }
#   allow {
#     protocol = "tcp"
#     ports    = ["0-65535"]
#   }
#   allow {
#     protocol = "udp"
#     ports    = ["0-65535"]
#   }
#   source_ranges = [
#     "10.160.104.0/21",
#     "10.242.128.0/17",
#     "10.243.0.0/22"
#   ]
# }
