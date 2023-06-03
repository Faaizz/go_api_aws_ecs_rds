output "s3_bucket" {
  description = "The ID of the S3 bucket"
  value       = module.s3.s3_bucket_id
}
output "dynamodb_table" {
  description = "The ID of the DynamoDB table"
  value       = module.dynamodb_table.dynamodb_table_id
}
output "ecr_repository" {
  description = "The name of the ECR repository"
  value       = aws_ecr_repository.this.name
}
