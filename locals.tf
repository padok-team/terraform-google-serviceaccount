locals {
  name_external_project_role_pairs = setproduct([var.name], toset(var.external_project_roles))
  external_project_roles_map_data = zipmap(
    [for pair in local.name_external_project_role_pairs : "${pair[0]}-${pair[1]}"],
    [for pair in local.name_external_project_role_pairs : {
      name = pair[0]
      role = pair[1]
    }]
  )
  name_bucket_role_pairs = setproduct([var.name], toset(var.bucket_roles))
  bucket_roles_map_data = zipmap(
    [for pair in local.name_bucket_role_pairs : "${pair[0]}-${pair[1]}"],
    [for pair in local.name_bucket_role_pairs : {
      name = pair[0]
      role = pair[1]
    }]
  )
  name_secret_role_pairs = setproduct([var.name], toset(var.secret_roles))
  secret_roles_map_data = zipmap(
    [for pair in local.name_secret_role_pairs : "${pair[0]}-${pair[1]}"],
    [for pair in local.name_secret_role_pairs : {
      name = pair[0]
      role = pair[1]
    }]
  )
  name_service_account_role_pairs = setproduct([var.name], toset(var.service_account_roles))
  service_account_roles_map_data = zipmap(
    [for pair in local.name_service_account_role_pairs : "${pair[0]}-${pair[1]}"],
    [for pair in local.name_service_account_role_pairs : {
      name = pair[0]
      role = pair[1]
    }]
  )
}
