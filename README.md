# Google Terraform module

Terraform module which creates **Service Account(s)** resources on **Google Cloud Platform**. 

## User Stories for this module

- AASRE I can deploy a single service account with no role(s) and permission(s)
- AASRE I can deploy a single service account with role(s) only
- AASRE I can deploy a single service account with permission(s) only
- AASRE I can deploy a single service account with permissions role(s) or permission(s) and a key
- AASRE I can deploy mutiple service accounts with both role(s) and permission(s)
- AASRE I can deploy mutiple service accounts with role(s), permission(s) and key

## Usage

```hcl
module "service_account" {
  source = "git@github.com:padok-team/terraform-google-serviceaccount.git"
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
      description = "Service account for Cloud SQL Instance"
      key         = true
    }
    "my-third-sa" = {
      roles = [
        "roles/apigateway.admin"
      ]
      description = "Service account for Cloud SQL Instance"
    }
    "my-fourth-sa" = {
      permissions = [
        "iam.roles.create"
      ]
      description = "Service account for Cloud SQL Instance"
    }
  }
}
```

## Examples

- [Examples for technical accounts](examples/example_for_technical_account/main.tf)

<!-- BEGIN_TF_DOCS -->
## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_service_accounts"></a> [service\_accounts](#input\_service\_accounts) | The list of service account which will be created by Terraform. You have to provide a description. Permissions, roles and key are optional. | <pre>map(object({<br>    permissions = optional(list(string)),<br>    roles       = optional(list(string)),<br>    key         = optional(bool),<br>    description = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_iam_custom_roles"></a> [project\_iam\_custom\_roles](#output\_project\_iam\_custom\_roles) | Custom roles for the project |
| <a name="output_service_account_emails"></a> [service\_account\_emails](#output\_service\_account\_emails) | Service account emails |
| <a name="output_service_account_keys"></a> [service\_account\_keys](#output\_service\_account\_keys) | Service account keys |
<!-- END_TF_DOCS -->

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```
