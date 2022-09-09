resource "google_service_account" "this" {
  project      = var.project_id
  account_id   = var.name
  description  = "Managed By Terraform"
  display_name = var.display_name
}

resource "google_project_iam_member" "this" {
  count = length(local.project_roles)
  project = local.project_roles[count.index].resource
  role    = local.project_roles[count.index].role
  member  = "serviceAccount:${google_service_account.this.email}"
}

resource "google_storage_bucket_iam_member" "this" {
  count = length(local.bucket_roles)
  bucket = local.bucket_roles[count.index].resource
  role   = local.bucket_roles[count.index].role
  member = "serviceAccount:${google_service_account.this.email}"
}

resource "google_secret_manager_secret_iam_member" "this" {
  count = length(local.secret_roles)
  secret_id = local.secret_roles[count.index].resource
  role      = local.secret_roles[count.index].role
  member    = "serviceAccount:${google_service_account.this.email}"
}


resource "google_service_account_iam_member" "this" {
  count = length(local.service_account_roles)
  service_account_id = local.service_account_roles[count.index].resource
  role               = local.service_account_roles[count.index].role
  member             = "serviceAccount:${google_service_account.this.email}"
}

resource "google_service_account_iam_member" "members" {
  count = length(local.members)
  service_account_id = google_service_account.this.name
  role               = local.members[count.index].role
  member             = local.members[count.index].resource
}

resource "google_service_account_iam_member" "kubernetes_members" {
  count = length(local.kubernetes_members)
  service_account_id = google_service_account.this.name
  role               = "roles/iam.workloadIdentityUser"
  member             = local.kubernetes_members[count.index]
}
