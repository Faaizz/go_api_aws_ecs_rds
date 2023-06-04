output "api_url" {
  description = "The URL of the API"
  value       = "http://${module.ecs.alb_dns_name}/api/v1"
}
