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
  postgresql_version            = "17"
  admin_username                = "postgresqlusername"
  admin_password                = null # Module generates a random password when null.
  sku_name                      = "B_Standard_B1ms"
  database_names                = ["maindb"]
  public_network_access_enabled = true
  log_analytics_workspace_id    = module.log-analytics.workspace_id
  cmk_encryption_enabled        = false

  # Firewall rules — only active when public_network_access_enabled = true
  firewall_rules = [
    {
      name             = "allow-my-ip"
      start_ip_address = "11.32.16.78"
      end_ip_address   = "11.32.16.78"
    }
    # Add more rules as needed:
    # {
    #   name             = "allow-office-range"
    #   start_ip_address = "10.0.0.1"
    #   end_ip_address   = "10.0.0.255"
    # }
  ]

  # All server params in one map — no more parallel lists
  server_configuration = {
    "pgaudit.log"                         = "ALL"
    "log_connections"                     = "on"
    "idle_in_transaction_session_timeout" = "300000"
    "azure.extensions"                    = "VECTOR,PGAUDIT,BTREE_GIST,CITEXT,CUBE"
  }

}
