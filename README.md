# Kubernetes Demo/Workshop Application

This project is part of the CSAP FY21 Q3 Devnet project at Cisco. The Devnet project is an opportunity to put into practice everything Devnet-related topics learned in the CSAP program so far. 

## Business challenge

Cisco is trying to position itself in the Kubernetes space with various products like CCP or AppD among others. Each of these products offer benefits for Kubernetes that can be demoed individually. There is no overarching demo that shows Cisco's capabilities accross different products though. 


## Goal of the project

The aim is to create a single application that is integrated with various tools, such as AppD or Intersight. The applicaition already exists, and many of the integrations are already working. To get this to the next level, the deployment have to automated to a larger degree. 


## Tasks

For this software project, the following tasks have been performed:

- [x] Creating Terraform scripts to automate the setup of various environments
- [x] Components that interact with the app have been set up. 
- [x] GKE clusters have been set up. 

This project is two-folded - this part focuses on deploying a GKE cluster and having AppD deployed on top of it.


**Process**

The first step in deploying an application in the cloud is to choose a cloud platform to deploy a kubernetes cluster in. For this project, Google Cloud was chosen as the cloud provider. A Google Cloud Platform (GCP) account was set up

Furthermore, an application can be deployed on top of a Google Kubernetes Engine (GKE) cluster using Terraform. Hence the next step is to define the GKE cluster in terraform.

Once the GKE cluster is defined and provisioned, the application is ready to be deployed in the cluster made. 

## Tools
**Terraform**
Terraform is an open-source infrastructure as a cose (IaaC) software tool created by HashiCorp. Using terraform, you can define and provide data center infrastructure using a declarative configuration language called HashiCorp Configuration Language (HCL). Using HCL, you define the infrastructure you want to be deployed, and Terraform will then execute those instructions. Rather than having to write the code to create the infrastructue, you define a plan of what you want executed. 


Modules defined in Terraform are a collection of resources. They can be referenced anywhere where the details in that module could be useful. 

A GCP network module was also defined to create a VPC for the cluster, and sets up subnet ranges for the pods and services. 

The GKE module creates the actual GKE cluster. Speficications such as name, regions, network, node pools, storage and virtual hardware resources are defined in this module.   

Due to the AppD module and the google module have versions that are not compatible with each other, the modules were run on two separate scripts.


**Files**

- `variables.tf` defines the variables and the values that the variables hold for the cluster. The values can also be defined in Terraform cloud. 
- `provider.tf` defines the providers for the cluster. Google and Kubernetes providers were defined. 
- `main.tf` defines the GKE cluster and creates a resource block where a local kubeconfig file stores necessarry information for the cluster. 


**Terraform cloud**
k

## Potentials

Integrate with ThousandEyes.

Could do Machine Learning on top of Kubernetes. 

Have the GKE cluster and AppD module running on the same script and not two separate ones. 

## Sponsors

Field sponsor for this project is Michael Maurer and ASE manager is Nicholas Nicolas Cervigni. 




