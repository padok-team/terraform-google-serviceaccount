# CLOUD_PROVIDER TYPE Terraform module

Terraform module which creates **Service Account(s)** resources on **CLOUD_PROVIDER**. This module is an abstraction of the [MODULE_NAME](https://github.com/a_great_module) by [@someoneverysmart](https://github.com/someoneverysmart).

## License

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## User Stories for this module

- AASRE I can deploy a single service account with no role(s) and permission(s)
- AASRE I can deploy a single service account with role(s) only
- AASRE I can deploy a single service account with permission(s) only
- AASRE I can deploy a single service account with permissions role(s) or permission(s) and a key
- AASRE I can deploy mutiple service accounts with both role(s) and permission(s)
- AASRE I can deploy mutiple service accounts with role(s), permission(s) and key

## Usage

```hcl
module "my_service_accounts" {
  source = "../.."
  service_accounts = {
    "my-first-sa" = {
      permissions = [
        "iam.roles.create",
        "iam.roles.delete",
        "iam.roles.undelete",
        "iam.roles.get",
        "iam.roles.list"
      ]
      roles = [
        "roles/apigateway.admin",
        "roles/cloudbuild.builds.builder",
        "roles/cloudfunctions.admin",
        "roles/cloudsql.admin",
        "roles/compute.admin",
        "roles/container.admin",
        "roles/dns.admin",
        "roles/firebase.admin",
        "roles/firebasestorage.admin",
        "roles/logging.admin",
        "roles/monitoring.admin",
        "roles/networkmanagement.admin",
        "roles/pubsub.admin",
        "roles/redis.admin",
        "roles/run.admin",
        "roles/secretmanager.admin",
        "roles/securitycenter.admin",
        "roles/storage.admin",
        "roles/vpcaccess.admin",
        "roles/iap.admin",
        "roles/iam.securityAdmin",
        "roles/iap.httpsResourceAccessor"
      ]
      description = "Service account for managing IAM roles"
      key         = false
    }
    "my-second-sa" = {
      permissions = [
        "cloudsql.instances.get",
        "cloudsql.instances.login"
      ]
      description = "Service account for Cloud SQL Instance"
      key         = true
    }
  }
}
```

## Examples

- [Example for technical accounts](examples/example_for_technical_account/main.tf)

<!-- BEGIN_TF_DOCS -->
## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_service_accounts"></a> [service\_accounts](#input\_service\_accounts) | test | <pre>map(object({<br>    permissions = optional(list(string)),<br>    roles       = optional(list(string)),<br>    key         = optional(bool),<br>    description = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_iam_custom_roles"></a> [project\_iam\_custom\_roles](#output\_project\_iam\_custom\_roles) | n/a |
| <a name="output_service_account_keys"></a> [service\_account\_keys](#output\_service\_account\_keys) | n/a |
<!-- END_TF_DOCS -->
