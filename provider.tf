

provider "google" {
  project = var.project
  region  = var.region
  }


provider "kubernetes" {
load_config_file = true
config_path = "kubeconfig-env_name"
}
