data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs              = slice(data.aws_availability_zones.available.names, 0, 3)
  subnet_cidrs     = cidrsubnets(var.cidr, 2, 2, 2)
  public_subnets   = cidrsubnets(local.subnet_cidrs[0], 1, 1)
  private_subnets  = cidrsubnets(local.subnet_cidrs[1], 1, 1)
  database_subnets = cidrsubnets(local.subnet_cidrs[2], 1, 1)
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.name
  cidr = var.cidr

  azs              = local.azs
  private_subnets  = local.private_subnets
  public_subnets   = local.public_subnets
  database_subnets = local.database_subnets

  create_database_subnet_group = true

  enable_nat_gateway = true
  single_nat_gateway = true
}


resource "aws_security_group" "alb" {
  name        = "allow_all_HTTP"
  description = "Allow HTTPS from everywhere"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs" {
  name        = "allow_HTTP_from_alb"
  description = "Allow HTTP from ALB SG"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Allow HTTP"
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "TCP"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "database" {
  name        = "allow_5432_from_vpc"
  description = "Allow Postgres from within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Allow Postgres"
    from_port       = 5432
    to_port         = 5432
    protocol        = "TCP"
    security_groups = [aws_security_group.ecs.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
