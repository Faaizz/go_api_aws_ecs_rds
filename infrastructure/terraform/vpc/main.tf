locals {
  project = "go-api-aws-ecs-rds"
  cidr    = "172.16.0.0/16"
}

module "vpc" {
  source = "../modules/vpc"

  name = "${local.project}-vpc"
  cidr = local.cidr

  container_port     = 8080
  web_container_port = 3000
}
