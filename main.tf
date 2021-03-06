resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = var.location
}

module "ssh-key" {
  source         = "./modules/ssh-key"
  public_ssh_key = var.public_ssh_key == "" ? "" : var.public_ssh_key
}

module "kubernetes" {
  source                               = "./modules/kubernetes-cluster"
  prefix                               = var.prefix
  api_server_authorized_ip_ranges      = var.api_server_authorized_ip_ranges
  enable_http_application_routing      = var.enable_http_application_routing
  resource_group_name                  = azurerm_resource_group.main.name
  location                             = azurerm_resource_group.main.location
  rbac_enabled                         = var.rbac_enabled
  admin_username                       = var.admin_username
  admin_public_ssh_key                 = var.public_ssh_key == "" ? module.ssh-key.public_ssh_key : var.public_ssh_key
  kubernetes_version                   = var.kubernetes_version
  service_principal_client_id          = var.CLIENT_ID
  service_principal_client_secret      = var.CLIENT_SECRET
  log_analytics_workspace_id           = var.log_analytics_workspace_id
  agent_pool_profile                   = var.agent_pool_profile
  default_node_pool                    = var.default_node_pool
  default_node_pool_availability_zones = var.default_node_pool_availability_zones
  default_node_pool_node_taints        = var.default_node_pool_node_taints
  network_profile                      = var.network_profile
  tags                                 = var.tags
}
