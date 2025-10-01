provider "azurerm" {
  features {}
}

##-----------------------------------------------------------------------------
## Resource Group module call
## Resource group in which all resources will be deployed.
##-----------------------------------------------------------------------------
module "resource_group" {
  source      = "terraform-az-modules/resource-group/azure"
  version     = "1.0.0"
  name        = "core"
  environment = "dev"
  location    = "centralindia"
  label_order = ["name", "environment", "location"]
}

# ------------------------------------------------------------------------------
# Log Analytics
# ------------------------------------------------------------------------------
module "log-analytics" {
  source                      = "terraform-az-modules/log-analytics/azure"
  version                     = "1.0.0"
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
  postgresql_version = "16"
  admin_username     = "postgresqlusername"
  admin_password     = null # Null value will generate random password and added to tfstate file.
  tier               = "Burstable"
  size               = "B1ms"
  database_names     = ["maindb"]
  high_availability = {
    mode                      = "ZoneRedundant"
    standby_availability_zone = 2
  }
  public_network_access_enabled = true
  allowed_cidrs = {
    # WARNING: This allows access from any IP address. For production, restrict this to known IPs.
    "allowed_all_ip"      = "0.0.0.0/0"
    "allowed_specific_ip" = "11.32.16.78/32"
  }
  log_analytics_workspace_id = module.log-analytics.workspace_id
  cmk_encryption_enabled     = false
}