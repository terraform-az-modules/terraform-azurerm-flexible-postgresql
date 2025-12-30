provider "azurerm" {
  features {}
}

##-----------------------------------------------------------------------------
## Resource Group module call
## Resource group in which all resources will be deployed.
##-----------------------------------------------------------------------------
module "resource_group" {
  source      = "terraform-az-modules/resource-group/azurerm"
  version     = "1.0.3"
  name        = "core"
  environment = "dev"
  location    = "centralindia"
  label_order = ["name", "environment", "location"]
}

# ------------------------------------------------------------------------------
# Log Analytics
# ------------------------------------------------------------------------------
module "log-analytics" {
  source                      = "terraform-az-modules/log-analytics/azurerm"
  version                     = "1.0.2"
  name                        = "core"
  environment                 = "dev"
  label_order                 = ["name", "environment", "location"]
  log_analytics_workspace_sku = "PerGB2018"
  resource_group_name         = module.resource_group.resource_group_name
  location                    = module.resource_group.resource_group_location
  log_analytics_workspace_id  = module.log-analytics.workspace_id
}

# ------------------------------------------------------------------------------
# Flexible Postgresql
# ------------------------------------------------------------------------------
module "flexible-postgresql" {
  depends_on          = [module.resource_group]
  source              = "../.."
  name                = "core"
  environment         = "test"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  #server configuration
  postgresql_version            = "18"
  admin_username                = "postgresqlusername"
  admin_password                = "test_password" # Null value will generate random password and added to tfstate file.
  sku_name                      = "B_Standard_B1ms"
  database_names                = ["maindb"]
  public_network_access_enabled = true
  log_analytics_workspace_id    = module.log-analytics.workspace_id
  cmk_encryption_enabled        = false
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_specific_ip" {
  name             = "allow-specific-ip"
  server_id        = module.flexible-postgresql.postgresql_flexible_server_id
  start_ip_address = "11.32.16.78" #replace it with you ip range 
  end_ip_address   = "11.32.16.78" #replace it with you ip range
}
