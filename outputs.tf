output "postgresql_flexible_server_id" {
  value       = try(azurerm_postgresql_flexible_server.main[0].id, null)
  description = "The ID of the PostgreSQL Flexible Server."
}

output "postgresql_flexible_server_name" {
  value       = try(azurerm_postgresql_flexible_server.main[0].fqdn, null)
  description = "The FQDN of the PostgreSQL Flexible Server."
}

output "firewall_rule_ids" {
  description = "Map of firewall rule names to their resource IDs."
  value       = { for k, v in azurerm_postgresql_flexible_server_firewall_rule.main : k => v.id }
}
