# Deploying GKE cluster


## Features

The following tasks have been performed:

- Creating Terraform scripts to automate the setup of various environments
- Components that interact with the app have been set up. 
- GKE clusters have been set up. 

## Usage

**Provisioning infrastructure with Terraform**

The Terraform scripts in this project provide the basic elements and structure of a GKE cluster. It includes the following scripts: 

- `variables.tf` defines the variables and the values that the variables hold for the cluster. The values can also be defined in Terraform cloud. 
- `provider.tf` defines the providers for the cluster. Google and Kubernetes providers were defined. 
- `main.tf` defines the GKE cluster and creates a resource block with a local kubeconfig file. 

Modules defined in `main.tf` are a collection of resources. They can be referenced anywhere where the details in that particular module would be useful. 

```
module "gcp-network" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 2.5"
  project_id   = var.project
  network_name = "kubernetes"
  subnets = [
    {
      subnet_name   = "subnet"
      subnet_ip     = "10.10.0.0/16"
      subnet_region = var.region
    },
   ]
  secondary_ranges = {
    "subnet" = [
      {
        range_name    = "pods"
        ip_cidr_range = "10.20.0.0/16"
      },
      {
        range_name    = "services"
        ip_cidr_range = "10.30.0.0/16"
      },
    ]
  }
}
```

A GCP network module was defined to create a VPC for the cluster and set up subnet ranges for the pods and services. 

```
module "gke" {
  source                 = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id             = var.project
  name                   = "gke"
  regional               = true
  region                 = var.region
  network                = module.gcp-network.network_name
  subnetwork             = module.gcp-network.subnets_names[0]
  ip_range_pods          = "pods"
  ip_range_services      = "services"
  node_pools = [
    {
      name                      = "node-pool"
      machine_type              = "e2-medium"
      node_locations            = "europe-west3-a,europe-west3-b"
      min_count                 = 1
      max_count                 = 2
      disk_size_gb              = 30
    },
  ]
}
```

The GKE module creates the actual GKE cluster. Specifications such as name, regions, node pools, storage, and virtual hardware resources are defined in this module. The GCP network module mentioned earlier is also referenced in this module in order to route traffic within the same node, between nodes of the same cluster, and other network-enabled resources on the same VPC. 

Ultimately, the credentials for the GKE cluster can be found in your Google Service Account. They can be referenced in Terraform, where they are used to authenticate and connect to the created GKE cluster. An AppDynamics module can further fetch the GKE cluster using the credentials, allowing the application to be deployed on the GKE cluster.



## Inputs

| Name | Description | Type | Required |
|------|-------------|-------|:--------:|
| <a name="project"></a> [project](#input\_project) | The GCP Project ID. | `string` | yes |
| <a name="region"></a> [region](#input\_region) | The region to host the GKE cluster in. | `string` | yes |
| <a name="location"></a> [location](#input\_location) | The location (zone) in the region to host the GKE cluster. | `string` | yes |
| <a name="appd_account_name"></a> [appd\_account\_name](#input\_appd\_account\_name) | Account name needed to log into AppDynamics Dashboard. | `string` | yes |
| <a name="appd_global_account"></a> [appd\_global\_account](#input\_appd\_global\_account) | Global AppDynamics account. Found in AppDynamics Dashboard under Settings - License - Account. | `string` | yes |
| <a name="appd_controller_key"></a> [appd\_controller\_key](#input\_appd\_controller\_key) | AppDynamics controller key. Found in AppDynamics Dashboard under Settings - License - Account. | `string` | yes |
| <a name="appd_username"></a> [appd\_username](#input\_appd\_username) | Username needed to log into AppDynamics Dashboard. | `string` | yes |
| <a name="appd_password"></a> [appd\_password](#input\_appd\_password) | Password needed to log into AppDynamics Dashboard. | `string` | yes |
