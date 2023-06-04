output "endpoint_url" {
  description = "The URL of the API"
  value       = "${module.ecs.alb_dns_name}/api/v1"
}
