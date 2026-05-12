output "connection_name" {
  description = "Cloud SQL connection name (project:region:instance)"
  value       = google_sql_database_instance.this.connection_name
}

output "public_ip_address" {
  description = "Public IP address of the instance (if enabled)"
  value       = google_sql_database_instance.this.public_ip_address
}

output "private_ip_address" {
  description = "Private IP address of the instance"
  value       = google_sql_database_instance.this.private_ip_address
}

output "database_name" {
  description = "Name of the default database"
  value       = google_sql_database.this.name
}

output "username" {
  description = "Master username"
  value       = google_sql_user.this.name
}

output "password" {
  description = "Master password"
  value       = local.db_password
  sensitive   = true
}

output "connection_uri" {
  description = "PostgreSQL connection URI for the SlackerNews Helm chart"
  value       = "postgres://${google_sql_user.this.name}:${local.db_password}@${coalesce(google_sql_database_instance.this.private_ip_address, google_sql_database_instance.this.public_ip_address)}:5432/${google_sql_database.this.name}"
  sensitive   = true
}

output "tier" {
  description = "The machine tier used"
  value       = local.tier
}

output "disk_size" {
  description = "The disk size in GiB"
  value       = local.disk_size
}
