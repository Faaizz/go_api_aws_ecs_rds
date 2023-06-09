output "db_instance_name" {
  description = "The name of the database"
  value       = module.rds.db_instance_name
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.rds.db_instance_address
}
output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.rds.db_instance_endpoint
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = module.rds.db_instance_username
  sensitive   = true
}
output "db_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = module.rds.db_instance_password
  sensitive   = true
}
output "db_instance_port" {
  description = "The database port"
  value       = module.rds.db_instance_port
}
