##-----------------------------------------------------------------------------
## Data
##-----------------------------------------------------------------------------
data "azurerm_client_config" "current" {}

data "azuread_group" "main" {
  count        = var.active_directory_auth_enabled && var.principal_name != null ? 1 : 0
  display_name = var.principal_name
}