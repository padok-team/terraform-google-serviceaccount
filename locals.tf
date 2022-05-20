locals {
  names                  = toset(var.names)
  name_bucket_role_pairs = setproduct(local.names, toset(var.bucket_roles))
  project_roles          = [for role in var.project_roles : "${var.project_id}=>${role}"]
  bucket_roles_map_data = zipmap(
    [for pair in local.name_bucket_role_pairs : "${pair[0]}-${pair[1]}"],
    [for pair in local.name_bucket_role_pairs : {
      name = pair[0]
      role = pair[1]
    }]
  )
  name_secret_role_pairs = setproduct(local.names, toset(var.secret_roles))
  secret_roles_map_data = zipmap(
    [for pair in local.name_secret_role_pairs : "${pair[0]}-${pair[1]}"],
    [for pair in local.name_secret_role_pairs : {
      name = pair[0]
      role = pair[1]
    }]
  )
  name_service_account_role_pairs = setproduct(local.names, toset(var.service_account_roles))
  service_account_roles_map_data = zipmap(
    [for pair in local.name_service_account_role_pairs : "${pair[0]}-${pair[1]}"],
    [for pair in local.name_service_account_role_pairs : {
      name = pair[0]
      role = pair[1]
    }]
  )
}
