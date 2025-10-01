##-----------------------------------------------------------------------------
## Random Password Resource.
## Will be passed as admin password of postgresql server when admin password is not passed manually as variable.
##-----------------------------------------------------------------------------
resource "random_password" "main" {
  count       = var.enabled && var.admin_password == null ? 1 : 0
  length      = var.admin_password_length
  min_upper   = var.min_upper
  min_lower   = var.min_lower
  min_numeric = var.min_numeric
  special     = var.special
}

##-----------------------------------------------------------------------------
## Labels module callled that will be used for naming and tags.
##-----------------------------------------------------------------------------
module "labels" {
  source          = "terraform-az-modules/tags/azure"
  version         = "1.0.0"
  name            = var.name
  location        = var.location
  environment     = var.environment
  managedby       = var.managedby
  label_order     = var.label_order
  repository      = var.repository
  deployment_mode = var.deployment_mode
  extra_tags      = var.extra_tags
}

##----------------------------------------------------------------------------- 
## Below resource will create postgresql flexible server.    
##-----------------------------------------------------------------------------
resource "azurerm_postgresql_flexible_server" "main" {
  count                             = var.enabled ? 1 : 0
  name                              = var.resource_position_prefix ? format("pgsql-fs-%s", local.name) : format("%s-pgsql-fs", local.name)
  resource_group_name               = var.resource_group_name
  location                          = var.location
  administrator_login               = var.admin_username
  administrator_password            = var.admin_password == null ? random_password.main[0].result : var.admin_password
  backup_retention_days             = var.backup_retention_days
  delegated_subnet_id               = var.delegated_subnet_id
  sku_name                          = join("_", [lookup(var.tier_map, var.tier, "GeneralPurpose"), "Standard", var.size])
  create_mode                       = var.create_mode
  geo_redundant_backup_enabled      = var.geo_redundant_backup_enabled
  point_in_time_restore_time_in_utc = var.create_mode == "PointInTimeRestore" ? var.point_in_time_restore_time_in_utc : null
  public_network_access_enabled     = var.public_network_access_enabled
  source_server_id                  = var.create_mode == "PointInTimeRestore" ? var.source_server_id : null
  storage_mb                        = var.storage_mb
  version                           = var.postgresql_version
  zone                              = var.zone
  tags                              = module.labels.tags
  dynamic "high_availability" {
    for_each = toset(var.high_availability != null && var.tier != "GeneralPurpose" ? [var.high_availability] : [])

    content {
      mode                      = "ZoneRedundant"
      standby_availability_zone = lookup(high_availability.value, "standby_availability_zone", 1)
    }
  }

  dynamic "maintenance_window" {
    for_each = toset(var.maintenance_window != null ? [var.maintenance_window] : [])
    content {
      day_of_week  = lookup(maintenance_window.value, "day_of_week", 0)
      start_hour   = lookup(maintenance_window.value, "start_hour", 0)
      start_minute = lookup(maintenance_window.value, "start_minute", 0)
    }
  }

  dynamic "authentication" {
    for_each = var.enabled && var.active_directory_auth_enabled ? [1] : [0]
    content {
      active_directory_auth_enabled = var.active_directory_auth_enabled
      tenant_id                     = data.azurerm_client_config.current.tenant_id
    }
  }

  dynamic "identity" {
    for_each = var.cmk_encryption_enabled ? [1] : []
    content {
      type         = "UserAssigned"
      identity_ids = [azurerm_user_assigned_identity.identity[0].id]
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.cmk_encryption_enabled ? [1] : []
    content {
      key_vault_key_id                     = azurerm_key_vault_key.main[0].id
      primary_user_assigned_identity_id    = azurerm_user_assigned_identity.identity[0].id
      geo_backup_key_vault_key_id          = var.geo_redundant_backup_enabled ? var.geo_backup_key_vault_key_id : null
      geo_backup_user_assigned_identity_id = var.geo_redundant_backup_enabled ? var.geo_backup_user_assigned_identity_id : null
    }
  }

  lifecycle {
    ignore_changes = [high_availability[0].standby_availability_zone]
  }
}

##-----------------------------------------------------------------------------
## Below resource will create PostgreSQL server Active Directory administrator.
##-----------------------------------------------------------------------------
resource "azurerm_postgresql_flexible_server_active_directory_administrator" "main" {
  count               = var.enabled && var.active_directory_auth_enabled ? 1 : 0
  server_name         = azurerm_postgresql_flexible_server.main[0].name
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  object_id           = var.object_id
  principal_name      = var.principal_name
  principal_type      = var.principal_type
}

##----------------------------------------------------------------------------- 
## Below resource will create key vault key that will be used for encryption.  
##-----------------------------------------------------------------------------
resource "azurerm_key_vault_key" "main" {
  depends_on      = [azurerm_role_assignment.identity_assigned, azurerm_role_assignment.rbac_keyvault_crypto_officer]
  count           = var.enabled && var.cmk_encryption_enabled ? 1 : 0
  name            = var.resource_position_prefix ? format("pgsql-kv-key-%s", local.name) : format("%s-pgsql-kv-key", local.name)
  expiration_date = var.expiration_date
  key_vault_id    = var.key_vault_id
  key_type        = var.key_type
  key_size        = var.key_size
  key_opts        = var.key_opts
  dynamic "rotation_policy" {
    for_each = var.rotation_policy != null ? var.rotation_policy : {}
    content {
      automatic {
        time_before_expiry = rotation_policy.value.time_before_expiry
      }

      expire_after         = rotation_policy.value.expire_after
      notify_before_expiry = rotation_policy.value.notify_before_expiry
    }
  }
}

##----------------------------------------------------------------------------- 
## Below resource will create Firewall rules for Public server.
##-----------------------------------------------------------------------------
resource "azurerm_postgresql_flexible_server_firewall_rule" "main" {
  for_each = var.enabled && var.public_network_access_enabled ? var.allowed_cidrs : {}

  name             = each.key
  server_id        = azurerm_postgresql_flexible_server.main[0].id
  start_ip_address = cidrhost(each.value, 0)
  end_ip_address   = cidrhost(each.value, -1)
}

##-----------------------------------------------------------------------------
## Below resource will create postgresql flexible database.
##-----------------------------------------------------------------------------
resource "azurerm_postgresql_flexible_server_database" "main" {
  for_each   = var.enabled ? toset(var.database_names) : []
  name       = each.value
  server_id  = azurerm_postgresql_flexible_server.main[0].id
  charset    = var.charset
  collation  = var.collation
  depends_on = [azurerm_postgresql_flexible_server.main]
}

resource "azurerm_postgresql_flexible_server_configuration" "main" {
  for_each   = var.enabled ? var.server_configurations : {}
  name       = each.key
  server_id  = azurerm_postgresql_flexible_server.main[0].id
  value      = each.value
  depends_on = [azurerm_postgresql_flexible_server.main]
}

resource "azurerm_monitor_diagnostic_setting" "main" {
  count                          = var.enabled && var.enable_diagnostic ? 1 : 0
  name                           = var.resource_position_prefix ? format("pgsql-diag-log-%s", local.name) : format("%s-pgsql-diag-log", local.name)
  target_resource_id             = azurerm_postgresql_flexible_server.main[0].id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  storage_account_id             = var.storage_account_id
  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  log_analytics_destination_type = var.log_analytics_destination_type
  dynamic "enabled_log" {
    for_each = length(var.log_category) > 0 ? var.log_category : var.log_category_group
    content {
      category       = length(var.log_category) > 0 ? enabled_log.value : null
      category_group = length(var.log_category) > 0 ? null : enabled_log.value
    }
  }

  dynamic "enabled_metric" {
    for_each = var.metric_enabled ? ["AllMetrics"] : []
    content {
      category = enabled_metric.value
    }
  }
  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}