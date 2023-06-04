terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.1.0"
    }
  }

  backend "s3" {
    bucket = "go-api-aws-ecs-rds-tf-state-bucket"
    key    = "ecs/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "go-api-aws-ecs-rds-tf-state-lock"
  }
}
