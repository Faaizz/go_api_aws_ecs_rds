# rds

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds"></a> [rds](#module\_rds) | terraform-aws-modules/rds/aws | 5.9.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_subnet_group"></a> [database\_subnet\_group](#input\_database\_subnet\_group) | The name of the database subnet group to use | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The name of the database to create | `string` | n/a | yes |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | The username for the master DB user | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the RDS instance | `string` | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | The ID of the security group to use | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_instance_address"></a> [db\_instance\_address](#output\_db\_instance\_address) | The address of the RDS instance |
| <a name="output_db_instance_endpoint"></a> [db\_instance\_endpoint](#output\_db\_instance\_endpoint) | The connection endpoint |
| <a name="output_db_instance_name"></a> [db\_instance\_name](#output\_db\_instance\_name) | The name of the database |
| <a name="output_db_instance_password"></a> [db\_instance\_password](#output\_db\_instance\_password) | The database password (this password may be old, because Terraform doesn't track it after initial creation) |
| <a name="output_db_instance_port"></a> [db\_instance\_port](#output\_db\_instance\_port) | The database port |
| <a name="output_db_instance_username"></a> [db\_instance\_username](#output\_db\_instance\_username) | The master username for the database |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
