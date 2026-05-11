output "endpoint" {
  description = "RDS instance endpoint (host:port)"
  value       = aws_db_instance.this.endpoint
}

output "host" {
  description = "RDS instance hostname"
  value       = aws_db_instance.this.address
}

output "port" {
  description = "RDS instance port"
  value       = aws_db_instance.this.port
}

output "database_name" {
  description = "Name of the default database"
  value       = aws_db_instance.this.db_name
}

output "username" {
  description = "Master username"
  value       = aws_db_instance.this.username
}

output "password" {
  description = "Master password"
  value       = local.db_password
  sensitive   = true
}

output "connection_uri" {
  description = "PostgreSQL connection URI for the SlackerNews Helm chart (postgres://...)"
  value       = "postgres://${aws_db_instance.this.username}:${local.db_password}@${aws_db_instance.this.address}:${aws_db_instance.this.port}/${aws_db_instance.this.db_name}"
  sensitive   = true
}

output "instance_class" {
  description = "The instance class used"
  value       = local.instance_class
}

output "allocated_storage" {
  description = "The allocated storage in GiB"
  value       = local.allocated_storage
}
