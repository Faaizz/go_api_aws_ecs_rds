# vpc

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.alb](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/security_group) | resource |
| [aws_security_group.database](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/security_group) | resource |
| [aws_security_group.ecs](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/security_group) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | The CIDR block of the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port the container listens on | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the VPC | `string` | n/a | yes |
| <a name="input_web_container_port"></a> [web\_container\_port](#input\_web\_container\_port) | The port the web container listens on | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_sg_id"></a> [alb\_sg\_id](#output\_alb\_sg\_id) | The ID of the ALB security group |
| <a name="output_database_sg_id"></a> [database\_sg\_id](#output\_database\_sg\_id) | The ID of the database security group |
| <a name="output_database_subnet_group"></a> [database\_subnet\_group](#output\_database\_subnet\_group) | The ID of the database subnet group |
| <a name="output_database_subnets"></a> [database\_subnets](#output\_database\_subnets) | The IDs of the database subnets |
| <a name="output_ecs_sg_id"></a> [ecs\_sg\_id](#output\_ecs\_sg\_id) | The ID of the ecs security group |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | The IDs of the private subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | The IDs of the public subnets |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
