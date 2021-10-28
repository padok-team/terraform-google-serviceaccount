# CLOUD_PROVIDER TYPE Terraform module

Terraform module which creates **TYPE** resources on **CLOUD_PROVIDER**. This module is an abstraction of the [MODULE_NAME](https://github.com/a_great_module) by [@someoneverysmart](https://github.com/someoneverysmart).

## User Stories for this module

- AATYPE I can be highly available or single zone
- ...

## Usage

```hcl
module "example" {
  source = "https://github.com/padok-team/terraform-aws-example"

  example_of_required_variable = "hello_world"
}
```

## Examples

- [Example of use case](examples/example_of_use_case/main.tf)
- [Example of other use case](examples/example_of_other_use_case/main.tf)

<!-- BEGIN_TF_DOCS -->
## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The account id that is used to generate the service account email address and a stable unique id. | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the service account. Can be updated without creating a new resource. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The ID of the project that the service account will be created in. Defaults to the provider project configuration. | `string` | n/a | yes |
| <a name="input_create_key"></a> [create\_key](#input\_create\_key) | Set to true to generate a key for this service account. | `bool` | `false` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | A list of roles for the service account | `list(string)` | <pre>[<br>  "roles/viewer"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_email"></a> [email](#output\_email) | n/a |
| <a name="output_service_account_private_key"></a> [service\_account\_private\_key](#output\_service\_account\_private\_key) | n/a |
| <a name="output_service_account_public_key"></a> [service\_account\_public\_key](#output\_service\_account\_public\_key) | n/a |
<!-- END_TF_DOCS -->
