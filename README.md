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
| <a name="input_bucket_roles"></a> [bucket\_roles](#input\_bucket\_roles) | n/a | `list(string)` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_external_project_roles"></a> [external\_project\_roles](#input\_external\_project\_roles) | n/a | `list(string)` | n/a | yes |
| <a name="input_kubernetes_members"></a> [kubernetes\_members](#input\_kubernetes\_members) | n/a | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project to deploy the ressrouces to. | `string` | n/a | yes |
| <a name="input_project_roles"></a> [project\_roles](#input\_project\_roles) | n/a | `list(string)` | n/a | yes |
| <a name="input_secret_roles"></a> [secret\_roles](#input\_secret\_roles) | n/a | `list(string)` | n/a | yes |
| <a name="input_service_account_roles"></a> [service\_account\_roles](#input\_service\_account\_roles) | n/a | `list(string)` | n/a | yes |

## Outputs

No outputs.
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
