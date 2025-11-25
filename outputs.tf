output "postgresql_flexible_server_id" {
  value       = try(azurerm_postgresql_flexible_server.main[0].id, null)
  description = "The ID of the PostgreSQL Flexible Server."
}

output "postgresql_flexible_server_name" {
  value       = try(azurerm_postgresql_flexible_server.main[0].fqdn, null)
  description = "The FQDN of the PostgreSQL Flexible Server."
}