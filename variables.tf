/* 

Copyright (c) 2021 Cisco and/or its affiliates.

This software is licensed to you under the terms of the Cisco Sample
Code License, Version 1.1 (the "License"). You may obtain a copy of the
License at

               https://developer.cisco.com/docs/licenses

All use of the material herein must be in accordance with the terms of
the License. All rights not expressly granted by the License are
reserved. Unless required by applicable law or agreed to separately in
writing, software distributed under the License is distributed on an "AS
IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
or implied.


*/


variable "apikey" {
  description = "Intersight API Key."
  type    = string
}

variable "secretkey" {
  description = "Intersight API Secret Key"
  type    = string
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
  description = "Global AppDynamics account. Found in AppDynamics Dashboard under Settings - License - Account."
  type = string
  }

variable "appd_controller_key" {
  description = "AppDynamics controller key. Found in AppDynamics Dashboard under Settings - License - Account."
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
