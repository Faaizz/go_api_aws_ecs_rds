variable "container_image_uri" {
  description = "The container image"
  type        = string
}

variable "basic_auth_user" {
  description = "The basic auth user"
  type        = string
}
variable "basic_auth_password" {
  description = "The basic auth password"
  type        = string
}
variable "db_user" {
  description = "The database user"
  type        = string
}
variable "db_password" {
  description = "The database password"
  type        = string
}
variable "db_name" {
  description = "The database name"
  type        = string
}
variable "db_host" {
  description = "The database host"
  type        = string
}
variable "db_port" {
  description = "The database port"
  type        = number
}

variable "ecs_subnets" {
  description = "The ECS subnets"
  type        = list(string)
}
variable "ecs_security_groups" {
  description = "The ECS security_groups"
  type        = list(string)
}
variable "alb_subnets" {
  description = "The ALB subnets"
  type        = list(string)
}
variable "alb_security_groups" {
  description = "The ALB security_groups"
  type        = list(string)
}
