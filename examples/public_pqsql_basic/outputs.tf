##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "flexible-postgresql_server_id" {
  value       = module.flexible-postgresql.postgresql_flexible_server_id
  description = "The ID of the PostgreSQL Flexible Server."
}

output "flexible-postgresql_server_name" {
  value       = module.flexible-postgresql.postgresql_flexible_server_name
  description = "The Name of the PostgreSQL Flexible Server."
}
