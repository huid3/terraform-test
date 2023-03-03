provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "25.0.0"

  project_id                 = var.project_id
  name                       = "gke-test-1"
  region                     = var.region
  network                    = module.gcp-network.network_name
  subnetwork                 = module.gcp-network.subnets_names[0]
  ip_range_pods              = var.ip_range_pods_name
  ip_range_services          = var.ip_range_services_name
  http_load_balancing        = true
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  create_service_account     = false
  gce_pd_csi_driver          = false
  default_max_pods_per_node  = 15

  node_pools = [
    {
      name               = "default-node-pool-test"
      machine_type       = "e2-medium"
      min_count          = 1
      max_count          = 1
      local_ssd_count    = 0
      spot               = false
      initial_node_count = 1
      preemptible        = false
      disk_type          = "pd-standard"
      disk_size_gb       = 10
    }
  ]
}