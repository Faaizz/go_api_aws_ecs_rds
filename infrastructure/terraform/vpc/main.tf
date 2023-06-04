locals {
  project = "go-api-aws-ecs-rds"
  cidr    = "172.16.0.0/16"
}

module "vpc" {
  source = "../modules/vpc"

  name = "${local.project}-vpc"
  cidr = local.cidr
}
