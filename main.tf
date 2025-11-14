##-----------------------------------------------------------------------------
## Tagging Module – Applies standard tags to all resources
##-----------------------------------------------------------------------------
module "labels" {
  source          = "terraform-az-modules/tags/azurerm"
  version         = "1.0.2"
  name            = var.custom_name == null ? var.name : var.custom_name
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
  count                  = var.enabled ? 1 : 0
  name                   = var.resource_position_prefix ? format("pgsql-fs-%s", local.name) : format("%s-pgsql-fs", local.name)
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.admin_username
  administrator_password = var.admin_password
  backup_retention_days  = var.backup_retention_days
  delegated_subnet_id    = var.delegated_subnet_id
  # private_dns_zone_id               = var.existing_private_dns_zone_id
  private_dns_zone_id               = var.private_dns_zone_ids
  public_network_access_enabled     = var.public_network_access_enabled
  sku_name                          = var.sku_name
  create_mode                       = var.create_mode
  geo_redundant_backup_enabled      = var.geo_redundant_backup_enabled
  point_in_time_restore_time_in_utc = var.create_mode == "PointInTimeRestore" ? var.point_in_time_restore_time_in_utc : null
  source_server_id                  = var.create_mode == "PointInTimeRestore" ? var.source_server_id : null
  storage_mb                        = var.storage_mb
  auto_grow_enabled                 = var.auto_grow_enabled
  version                           = var.postgresql_version
  zone                              = var.zone
  tags                              = module.labels.tags
  dynamic "high_availability" {
    for_each = toset(var.high_availability != null ? [var.high_availability] : [])

    content {
      mode                      = high_availability.value.mode
      standby_availability_zone = lookup(high_availability.value, "standby_availability_zone", 1)
    }
  }

  dynamic "authentication" {
    for_each = var.enabled && var.active_directory_auth_enabled ? [1] : [0]

    content {
      active_directory_auth_enabled = var.active_directory_auth_enabled
      tenant_id                     = data.azurerm_client_config.current.tenant_id
      password_auth_enabled         = var.password_auth_enabled
    }
  }
  dynamic "maintenance_window" {
    for_each = var.maintenance_window_enabled ? [1] : []

    content {
      day_of_week  = var.maintenance_window_day_of_week
      start_hour   = var.maintenance_window_start_hour
      start_minute = var.maintenance_window_start_minute
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
      key_vault_key_id                     = var.key_vault_id
      primary_user_assigned_identity_id    = azurerm_user_assigned_identity.identity[0].id
      geo_backup_key_vault_key_id          = var.geo_redundant_backup_enabled ? var.geo_backup_key_vault_key_id : null
      geo_backup_user_assigned_identity_id = var.geo_redundant_backup_enabled ? var.geo_backup_user_assigned_identity_id : null
    }
  }

  lifecycle {
    ignore_changes = [administrator_password, authentication]
  }

}

##-----------------------------------------------------------------------------
## Below resource will create postgresql flexible database.
##-----------------------------------------------------------------------------
resource "azurerm_postgresql_flexible_server_database" "main" {
  count      = var.enabled ? length(var.database_names) : 0
  name       = var.database_names[count.index]
  server_id  = join("", azurerm_postgresql_flexible_server.main.*.id)
  charset    = var.charset
  collation  = var.collation
  depends_on = [azurerm_postgresql_flexible_server.main]
}

resource "azurerm_postgresql_flexible_server_configuration" "main" {
  count     = var.enabled ? length(var.server_configuration_name) : 0
  name      = element(var.server_configuration_name, count.index)
  server_id = join("", azurerm_postgresql_flexible_server.main.*.id)
  value     = element(var.values, count.index)
}

##------------------------------------------------------------------------
## Manages a Customer Managed Key for a PostgreSQL Server. - Default is "false"
##------------------------------------------------------------------------
resource "azurerm_postgresql_server_key" "main" {
  count            = var.enabled && var.key_vault_key_id != null ? 1 : 0
  server_id        = join("", azurerm_postgresql_flexible_server.main.*.id)
  key_vault_key_id = var.key_vault_key_id
}

resource "azurerm_monitor_diagnostic_setting" "postgresql" {
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

  dynamic "metric" {
    for_each = var.metric_enabled ? ["AllMetrics"] : []
    content {
      category = metric.value
      enabled  = true
    }
  }
  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}

##-----------------------------------------------------------------------------
## Below resource will create PostgreSQL server Active Directory administrator.
##-----------------------------------------------------------------------------
resource "azurerm_postgresql_flexible_server_active_directory_administrator" "main" {
  count               = var.enabled && var.active_directory_auth_enabled && var.principal_name != null ? 1 : 0
  server_name         = azurerm_postgresql_flexible_server.main[0].name
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azuread_group.main[0].object_id
  principal_name      = var.principal_name
  principal_type      = var.principal_type
  lifecycle {
    ignore_changes = [tenant_id, object_id]
  }
}

##-----------------------------------------------------------------------------
## Private Endpoint 
##-----------------------------------------------------------------------------
resource "azurerm_private_endpoint" "pep" {
  count               = var.enabled && var.enable_private_endpoint ? 1 : 0
  name                = var.resource_position_prefix ? format("pgsql-pe-%s", local.name) : format("%s-pgsql-pe", local.name)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = module.labels.tags
  private_service_connection {
    name                           = var.resource_position_prefix ? format("pgsql-psc-%s", local.name) : format("%s-pgsql-psc", local.name)
    is_manual_connection           = false
    private_connection_resource_id = azurerm_postgresql_flexible_server.main[0].id
    subresource_names              = ["postgresqlServer"]
  }

  private_dns_zone_group {
    name                 = var.resource_position_prefix ? format("as-dns-zone-group-%s", local.name) : format("%s-as-dns-zone-group", local.name)
    private_dns_zone_ids = [var.private_dns_zone_ids]
  }
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}