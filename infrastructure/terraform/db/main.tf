data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "go-api-aws-ecs-rds-tf-state-bucket"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

locals {
  project = "go-api-aws-ecs-rds"
}

module "rds" {
  source = "../modules/rds"

  name = "${local.project}-db"

  db_name               = replace(local.project, "-", "")
  master_username       = replace(local.project, "-", "")
  database_subnet_group = data.terraform_remote_state.vpc.outputs.database_subnet_group
  security_group_id     = data.terraform_remote_state.vpc.outputs.database_sg_id
}
