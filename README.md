# Kubernetes Demo/Workshop Application

This project is part of the CSAP FY21 Q3 Devnet project at Cisco. The company wants to position itself in the Kubernetes space with various products like CCP or AppDynamics among others. Each of these products offers benefits for Kubernetes that can be demoed individually. 

The aim is to create a single application that is integrated with various tools, such as AppD or Intersight. The application already exists, and many of the integrations are already working. To get this to the next level, the deployment has to automate to a larger degree. 


## Features

For this software project, the following tasks have been performed:

- Creating Terraform scripts to automate the setup of various environments
- Components that interact with the app have been set up. 
- GKE clusters have been set up. 

This project is two-folded; this part focuses on deploying a GKE cluster and having AppDynamics deployed in it.

## Solution Components
- Terraform
- Terraform cloud
- Google cloud account 
- AppDynamics dashboard


## Installation

It is recommended to set up your environment as followed:

The first step to deploying an application in the cloud is to choose a cloud platform to deploy a Kubernetes cluster on. For this project, Google Cloud Platform was chosen as the cloud provider. A Google Cloud Platform (GCP) account was set up.

Furthermore, an application can be deployed on top of a Google Kubernetes Engine (GKE) cluster using Terraform. Hence, the next step is to define the GKE cluster in Terraform.

<p align="center">
<img width="470" alt="Screenshot 2021-05-02 at 12 14 07" src="https://user-images.githubusercontent.com/56272326/116809748-e6e52b80-ab3f-11eb-9fb7-60bb29e982a5.png">
</p>

Using version control such as GitHub and Terraform Cloud, multiple people could collaborate at the same time. Terraform Cloud integrates with GitHub, enabling Terraform to run automatically when changes are committed to the specified GitHub branch. Another benefit of using Terraform Cloud is that you can add values manually in a workspace. This is especially desirable for sensitive data, where only those with access to that workspace can access them. 

Finally, you can check in the AppDynamics UI whether the cluster has been successfully deployed. 

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

Ultimately, the credentials and certificates for the GKE cluster can be found in your Google Service Account. They can be referenced in Terraform, where they are used to authenticate the created GKE cluster. An AppDynamics module can further fetch the GKE cluster using the credentials, allowing the application to be deployed on the GKE cluster. 


## Documentation

The GKE module created in this project is also published in the following Terraform registery: 

https://registry.terraform.io/modules/namjachingu/gke-cisco/google/latest


## Credits

This project was inspired by the following article:

https://learnk8s.io/terraform-gke
