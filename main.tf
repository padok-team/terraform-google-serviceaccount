resource "google_service_account" "default" {
  project      = var.project_id
  account_id   = var.name
  description  = "Managed By Terraform"
  display_name = var.display_name
}

resource "google_project_iam_member" "default" {
  for_each = toset(var.project_roles)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.default.email}"
}

resource "google_project_iam_member" "external" {
  for_each = local.external_project_roles_map_data
  project  = element(split("=>", each.value.role), 0, )
  role     = element(split("=>", each.value.role), 1, )
  member   = "serviceAccount:${google_service_account.default.email}"
}

resource "google_storage_bucket_iam_member" "default" {
  for_each = local.bucket_roles_map_data
  bucket   = element(split("=>", each.value.role), 0, )
  role     = element(split("=>", each.value.role), 1, )
  member   = "serviceAccount:${google_service_account.default.email}"
}

resource "google_secret_manager_secret_iam_member" "default" {
  for_each  = local.secret_roles_map_data
  secret_id = element(split("=>", each.value.role), 0, )
  role      = element(split("=>", each.value.role), 1, )
  member    = "serviceAccount:${google_service_account.default.email}"
}

resource "google_service_account_iam_member" "default" {
  for_each           = local.service_account_roles_map_data
  service_account_id = element(split("=>", each.value.role), 0, ) == "this" ? google_service_account.default.name : element(split("=>", each.value.role), 0, )
  role               = element(split("=>", each.value.role), 1, )
  member             = "serviceAccount:${google_service_account.default.email}"
}

resource "google_service_account_iam_member" "members" {
  for_each           = toset(var.kubernetes_members)
  service_account_id = google_service_account.default.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${each.value}]"
}
