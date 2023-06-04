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
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ../modules/ecs | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.db](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_basic_auth_password"></a> [basic\_auth\_password](#input\_basic\_auth\_password) | The basic auth password | `string` | n/a | yes |
| <a name="input_basic_auth_user"></a> [basic\_auth\_user](#input\_basic\_auth\_user) | The basic auth user | `string` | n/a | yes |
| <a name="input_container_image_uri"></a> [container\_image\_uri](#input\_container\_image\_uri) | The container image | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_url"></a> [api\_url](#output\_api\_url) | The URL of the API |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
