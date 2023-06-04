variable "name" {
  description = "The name of the RDS instance"
  type        = string
}
variable "db_name" {
  description = "The name of the database to create"
  type        = string
}
variable "master_username" {
  description = "The username for the master DB user"
  type        = string
}

variable "database_subnet_group" {
  description = "The name of the database subnet group to use"
  type        = string
}
variable "security_group_id" {
  description = "The ID of the security group to use"
  type        = string
}
