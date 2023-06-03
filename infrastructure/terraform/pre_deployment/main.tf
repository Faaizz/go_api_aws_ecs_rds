locals {
  project = "go-api-aws-ecs-rds"
}

module "s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.11.0"

  bucket        = "${local.project}-tf-state-bucket"
  force_destroy = true
}

module "dynamodb_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "3.3.0"

  name     = "${local.project}-tf-state-lock"
  hash_key = "LockID"

  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]
}

resource "aws_ecr_repository" "this" {
  name         = local.project
  force_delete = true
}
