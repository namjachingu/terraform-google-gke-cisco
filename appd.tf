
 module "appdynamics" {
  source  = "3191110276/appdynamics/kubernetes"
  version = "0.2.1"
 
  depends_on = [
     local_file.kubeconfig   
   ]
  
  appd_account_name        = var.appd_account_name 
  appd_global_account      = var.appd_global_account 
  appd_controller_url      = "https://ceer.saas.appdynamics.com:443"
  appd_controller_hostname = "ceer.saas.appdynamics.com"
  appd_controller_key      = var.appd_controller_key  
  appd_username            = var.appd_username  
  appd_password            = var.appd_password 

  cluster_name = "cnb"

  ns_to_monitor = ["accounting", "appdynamics", "automation", "default", "iks", "iwo", "kube-node-lease", "kube-public", "kube-system", "order", "procurement"]
  ns_to_instrument = "procurement"

  instrumentation_app_name = "cnb-procurement"
   
  deploy_dbcollector = false
  
  
   
}
