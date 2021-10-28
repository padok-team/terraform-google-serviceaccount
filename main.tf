# Create our service account
resource "google_service_account" "this" {
  account_id   = var.account_id
  display_name = var.display_name
  project      = var.project
}

# Add roles to service account
resource "google_project_iam_member" "this" {
  for_each = toset(var.roles)
  project  = var.project
  role     = each.key
  member   = "serviceAccount:${google_service_account.this.email}"
}

# Generate a key for our service account
resource "google_service_account_key" "this" {
  count              = var.create_key == true ? 1 : 0
  service_account_id = google_service_account.this.name
}
