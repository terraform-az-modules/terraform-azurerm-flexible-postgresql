provider "azurerm" {
  features {}
}

##-----------------------------------------------------------------------------
## Resources
##-----------------------------------------------------------------------------
data "azurerm_client_config" "current_client_config" {}

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
# Virtual Network
# ------------------------------------------------------------------------------
module "vnet" {
  source              = "terraform-az-modules/vnet/azurerm"
  version             = "1.0.3"
  name                = "core"
  environment         = "dev"
  label_order         = ["name", "environment", "location"]
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_spaces      = ["10.0.0.0/16"]
}

# ------------------------------------------------------------------------------
# Subnet
# ------------------------------------------------------------------------------
module "subnet" {
  source               = "terraform-az-modules/subnet/azurerm"
  version              = "1.0.1"
  environment          = "dev"
  label_order          = ["name", "environment", "location"]
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.vnet_name
  subnets = [
    {
      name            = "subnet1"
      subnet_prefixes = ["10.0.1.0/24"]
      delegations = [
        {
          name = "delegation1"
          service_delegations = [
            {
              name    = "Microsoft.DBforPostgreSQL/flexibleServers"
              actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
            }
          ]
        }
      ]
    },
    {
      name            = "subnet2"
      subnet_prefixes = ["10.0.2.0/24"]
    }
  ]
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
# Key Vault
# ------------------------------------------------------------------------------
module "vault" {
  source                        = "terraform-az-modules/key-vault/azurerm"
  version                       = "1.0.1"
  name                          = "core"
  environment                   = "dev"
  label_order                   = ["name", "environment", "location"]
  resource_group_name           = module.resource_group.resource_group_name
  location                      = module.resource_group.resource_group_location
  subnet_id                     = module.subnet.subnet_ids["subnet2"]
  enable_rbac_authorization     = true
  private_dns_zone_ids          = module.private_dns.private_dns_zone_ids.key_vault
  public_network_access_enabled = true
  enable_access_policies        = false
  network_acls = {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = ["0.0.0.0/0"]
  }
  reader_objects_ids = {
    "Key Vault Administrator" = {
      role_definition_name = "Key Vault Administrator"
      principal_id         = data.azurerm_client_config.current_client_config.object_id
    }
  }
  diagnostic_setting_enable  = true
  log_analytics_workspace_id = module.log-analytics.workspace_id
}


##-----------------------------------------------------------------------------
## Private DNS Zone module call
##-----------------------------------------------------------------------------
module "private_dns" {
  source              = "terraform-az-modules/private-dns/azurerm"
  version             = "1.0.2"
  name                = "core"
  environment         = "dev"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  private_dns_config = [
    {
      resource_type = "key_vault"
      vnet_ids      = [module.vnet.vnet_id]
    },
    {
      resource_type = "postgresql_server"
      vnet_ids      = [module.vnet.vnet_id]
    }
  ]
}

# ------------------------------------------------------------------------------
# Flexible Postgresql
# ------------------------------------------------------------------------------
module "flexible-postgresql" {
  depends_on          = [module.resource_group, module.vnet, module.private_dns]
  source              = "../.."
  name                = "core"
  environment         = "dev"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  #server configuration
  postgresql_version = "17"
  admin_username     = "postgresqlusername"
  admin_password     = "test_password" # Null value will generate random password and added to tfstate file.
  sku_name           = "B_Standard_B1ms"
  database_names     = ["maindb"]
  #private server
  #(Resources to recreate when changing private to public cluster or vise-versa )
  log_analytics_workspace_id = module.log-analytics.workspace_id
  # Database encryption with costumer manage keys
  cmk_encryption_enabled  = true
  key_vault_id            = module.vault.id
  admin_objects_ids       = [data.azurerm_client_config.current_client_config.object_id]
  enable_private_endpoint = false
  private_dns_id          = module.private_dns.private_dns_zone_ids.postgresql_server #private_dns_id is passed when we don't use private endpoint
  delegated_subnet_id     = module.subnet.subnet_ids.subnet1

  # provide the required values to attach aad group
  active_directory_auth_enabled = true
  principal_name                = "test-db" # e.g., an AAD group name
}