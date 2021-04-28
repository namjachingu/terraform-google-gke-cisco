variable "apikey" {
  description = "Intersight API Key."
  type    = string
}

variable "secretkey" {
  description = "Intersight API Secret Key"
  type    = string
}

variable "te_token" {
  description = "ThousandEyes token."
  type = string  
}

variable "project" {
  description = "The GCP Project ID."
  type = string
}

variable "location" {
  description = "The location (region or zone) to host the GKE cluster."
  type        = string
  default = "europe-west3-a"	
}

variable "region" {
  description = "The region to host the GKE cluster in."
  type = string
}


variable "appd_account_name" {
  description = "Account name needed to log into AppDynamics Dashboard."
  type = string
  }

variable "appd_global_account" {
  description = "Global AppDynamics account in AppDynamics Dashboard. Found under Settings - License - Account."
  type = string
  }

variable "appd_controller_key" {
  description = "AppDynamics controller key in AppDynamics Dashboard. Found under Settings - License - Account."
  type = string
  }

variable "appd_username" {
  description = "Username needed to log into AppDynamics Dashboard."
  type = string
  }

variable "appd_password" {
  description = "Password needed to log into AppDynamics Dashboard."
  type = string
  }
