output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.rds_mysql.endpoint
}

output "rds_port" {
  description = "The port of the RDS instance"
  value       = aws_db_instance.rds_mysql.port
}

output "db_name" {
  description = "The database name"
  value       = var.db_name
}

output "db_username" {
  description = "The database username"
  value       = var.db_username
}

output "db_password" {
  description = "The database password"
  value       = var.db_password
  sensitive   = true
}