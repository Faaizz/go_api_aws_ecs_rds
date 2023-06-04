provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Project     = "go-api-aws-ecs-rds"
      Environment = "dev"
    }
  }
}
