output "api_url" {
  description = "The URL of the API"
  value       = "http://${module.ecs.alb_dns_name}/api/v1"
}

output "view_url" {
  description = "The URL of the view page"
  value       = "http://${module.ecs.alb_dns_name}"
}
