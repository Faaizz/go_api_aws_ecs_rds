output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = local.cidr
}
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnets
}
output "private_subnets" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnets
}
output "database_subnets" {
  description = "The IDs of the database subnets"
  value       = module.vpc.database_subnets
}
output "database_subnet_group" {
  description = "The ID of the database subnet group"
  value       = module.vpc.database_subnet_group
}

output "alb_sg_id" {
  description = "The ID of the ALB security group"
  value       = module.vpc.alb_sg_id
}
output "ecs_sg_id" {
  description = "The ID of the ecs security group"
  value       = module.vpc.ecs_sg_id
}
output "database_sg_id" {
  description = "The ID of the database security group"
  value       = module.vpc.database_sg_id
}
