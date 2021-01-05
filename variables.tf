# terraform-azurerm-aks variables

variable "api_server_authorized_ip_ranges" {
  default     = null
  description = "The IP ranges to whitelist for incoming traffic to the masters."
  type        = list(string)
}

variable "enable_http_application_routing" {
  default     = false
  description = "Is HTTP Application Routing Enabled? Changing this forces a new resource to be created."
  type        = bool
}

variable "prefix" {
  description = "The prefix for the resources created in the specified Azure Resource Group"
  type        = string
}

variable "rbac_enabled" {
  default     = true
  description = "Boolean to enable or disable role-based access control"
  type        = bool
}

variable "location" {
  default     = "eastus"
  description = "The location for the AKS deployment"
  type        = string
}

variable "CLIENT_ID" {
  description = "The Client ID (appId) for the Service Principal used for the AKS deployment"
  type        = string
}

variable "CLIENT_SECRET" {
  description = "The Client Secret (password) for the Service Principal used for the AKS deployment"
  type        = string
}

variable "admin_username" {
  default     = "azureuser"
  description = "The username of the local administrator to be created on the Kubernetes cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Version of Kubernetes to install"
  type        = string
}

variable "public_ssh_key" {
  description = "A custom ssh key to control access to the AKS cluster"
  default     = ""
  type        = string
}

variable "agent_pool_profile" {
  description = "An agent_pool_profile block, see terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html#agent_pool_profile"
  type        = list(any)
  default = [{
    name            = "nodepool"
    count           = 1
    vm_size         = "standard_f2"
    os_type         = "Linux"
    agents_count    = 2
    os_disk_size_gb = 50
  }]
}

variable "default_node_pool" {
  description = "A default_node_pool block, see terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html#default_node_pool"
  type        = map(any)
  default = {
    name                = "nodepool"
    vm_size             = "standard_f2"
    enable_auto_scaling = true
    os_disk_size_gb     = 50
    type                = "VirtualMachineScaleSets"
  }
}

variable "default_node_pool_availability_zones" {
  description = "The default_node_pools AZs"
  type        = list(string)
  default     = null
}

variable "default_node_pool_node_taints" {
  description = "The default_node_pools node taints"
  type        = list(string)
  default     = null
}

variable "network_profile" {
  description = "Variables defining the AKS network profile config"
  type = object({
    network_plugin     = string
    network_policy     = string
    dns_service_ip     = string
    docker_bridge_cidr = string
    pod_cidr           = string
    service_cidr       = string
    load_balancer_sku  = string
  })
  default = {
    network_plugin     = "kubenet"
    network_policy     = ""
    dns_service_ip     = ""
    docker_bridge_cidr = ""
    pod_cidr           = ""
    service_cidr       = ""
    load_balancer_sku  = "Basic"
  }
}

variable "tags" {
  default     = {}
  description = "Any tags that should be present on resources"
  type        = map(string)
}

variable "log_analytics_workspace_id" {
  default     = null
  description = "resource ID for log analytics workspace"
}
