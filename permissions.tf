##-----------------------------------------------------------------------------
## Permissions, Roles, and Policies
##-----------------------------------------------------------------------------

##----------------------------------------------------------------------------- 
## Below resource will create user assigned identity in your azure environment.  
##-----------------------------------------------------------------------------
resource "azurerm_user_assigned_identity" "identity" {
  count               = var.enabled && var.cmk_encryption_enabled ? 1 : 0
  location            = var.location
  name                = var.resource_position_prefix ? format("pgsql-mid-%s", local.name) : format("%s-pgsql-mid", local.name)
  resource_group_name = var.resource_group_name
}

##-----------------------------------------------------------------------------
## Below resource will provide user access on key vault based on role base access in azure environment.
##-----------------------------------------------------------------------------
resource "azurerm_role_assignment" "rbac_keyvault_crypto_officer" {
  for_each             = toset(var.enabled && var.cmk_encryption_enabled ? var.admin_objects_ids : [])
  scope                = var.key_vault_key_id
  role_definition_name = "Key Vault Crypto Officer"
  principal_id         = each.value
}

##----------------------------------------------------------------------------- 
## Below resource will assign 'Key Vault Crypto Service Encryption User' role to user assigned identity created above. 
##-----------------------------------------------------------------------------
resource "azurerm_role_assignment" "identity_assigned" {
  depends_on           = [azurerm_user_assigned_identity.identity]
  count                = var.enabled && var.cmk_encryption_enabled ? 1 : 0
  principal_id         = azurerm_user_assigned_identity.identity[0].principal_id
  scope                = var.key_vault_key_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
}
