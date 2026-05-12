output "fqdn" {
  description = "Fully qualified domain name of the Flexible Server"
  value       = azurerm_postgresql_flexible_server.this.fqdn
}

output "database_name" {
  description = "Name of the default database"
  value       = azurerm_postgresql_flexible_server_database.this.name
}

output "username" {
  description = "Administrator username"
  value       = azurerm_postgresql_flexible_server.this.administrator_login
}

output "password" {
  description = "Administrator password"
  value       = local.db_password
  sensitive   = true
}

output "connection_uri" {
  description = "PostgreSQL connection URI for the SlackerNews Helm chart"
  value       = "postgres://${azurerm_postgresql_flexible_server.this.administrator_login}:${local.db_password}@${azurerm_postgresql_flexible_server.this.fqdn}:5432/${azurerm_postgresql_flexible_server_database.this.name}"
  sensitive   = true
}

output "sku_name" {
  description = "The SKU name used"
  value       = local.sku_name
}

output "storage_mb" {
  description = "The storage size in MB"
  value       = local.storage_mb
}
