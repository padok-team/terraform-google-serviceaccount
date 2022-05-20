module "default" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "~> 4.0"

  project_id = var.project_id

  names        = var.names
  display_name = var.display_name

  project_roles = distinct(concat(local.project_roles, var.external_project_roles))
}

resource "google_storage_bucket_iam_member" "default" {
  for_each = local.bucket_roles_map_data
  bucket   = element(split("=>", each.value.role), 0, )
  role     = element(split("=>", each.value.role), 1, )
  member   = "serviceAccount:${module.default.email}"
}

resource "google_secret_manager_secret_iam_member" "default" {
  for_each = local.secret_roles_map_data
  secret_id   = element(split("=>", each.value.role), 0, )
  role     = element(split("=>", each.value.role), 1, )
  member   = "serviceAccount:${module.default.email}"
}

resource "google_service_account_iam_member" "default" {
  for_each           = local.service_account_roles_map_data
  service_account_id = element(split("=>", each.value.role), 0, ) == "this" ? module.default.service_account.name : element(split("=>", each.value.role), 0, )
  role               = element(split("=>", each.value.role), 1, )
  member   = "serviceAccount:${module.default.service_account.email}"
}

resource "google_service_account_iam_member" "members" {
  for_each           = toset(var.kubernetes_members)
  service_account_id = module.default.service_account.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${each.value}]"
}
