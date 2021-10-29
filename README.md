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
| <a name="input_list_serviceaccount"></a> [list\_serviceaccount](#input\_list\_serviceaccount) | test | <pre>map(object({<br>    permissions      = list(string),<br>    predifined_roles = list(string),<br>    key              = optional(bool),<br>    description      = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | n/a |
| <a name="output_service_account_private_key"></a> [service\_account\_private\_key](#output\_service\_account\_private\_key) | n/a |
| <a name="output_service_account_public_key"></a> [service\_account\_public\_key](#output\_service\_account\_public\_key) | n/a |
<!-- END_TF_DOCS -->
