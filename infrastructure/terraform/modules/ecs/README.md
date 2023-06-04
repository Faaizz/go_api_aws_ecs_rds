# ecs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.this](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.this](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/appautoscaling_target) | resource |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.task](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.task_exec](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.task](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/iam_role) | resource |
| [aws_iam_role.task_exec](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.task](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.task_exec](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/lb) | resource |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/lb_target_group) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_security_groups"></a> [alb\_security\_groups](#input\_alb\_security\_groups) | The ALB security\_groups | `list(string)` | n/a | yes |
| <a name="input_alb_subnets"></a> [alb\_subnets](#input\_alb\_subnets) | The ALB subnets | `list(string)` | n/a | yes |
| <a name="input_basic_auth_password"></a> [basic\_auth\_password](#input\_basic\_auth\_password) | The basic auth password | `string` | n/a | yes |
| <a name="input_basic_auth_user"></a> [basic\_auth\_user](#input\_basic\_auth\_user) | The basic auth user | `string` | n/a | yes |
| <a name="input_container_image_uri"></a> [container\_image\_uri](#input\_container\_image\_uri) | The container image | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port the container listens on | `number` | n/a | yes |
| <a name="input_db_host"></a> [db\_host](#input\_db\_host) | The database host | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The database name | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | The database password | `string` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | The database port | `string` | n/a | yes |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | The database user | `string` | n/a | yes |
| <a name="input_ecs_security_groups"></a> [ecs\_security\_groups](#input\_ecs\_security\_groups) | The ECS security\_groups | `list(string)` | n/a | yes |
| <a name="input_ecs_subnets"></a> [ecs\_subnets](#input\_ecs\_subnets) | The ECS subnets | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | The DNS name of the ALB |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
