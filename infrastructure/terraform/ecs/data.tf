data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = "go-api-aws-ecs-rds-tf-state-bucket"
    key    = "db/terraform.tfstate"
    region = "us-east-1"
  }
}
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "go-api-aws-ecs-rds-tf-state-bucket"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}
