data "google_iam_role" "roles" {
  for_each = toset(local.roles)
  name = each.value
}

locals {

  roles = flatten([for k,v in var.list_serviceaccount : v.roles])

  roles_permissions = {
    for k, v in var.list_serviceaccount : k => flatten([for r in v.roles : [flatten(data.google_iam_role.roles[r].included_permissions)]])
  }
}

# Create service account
resource "google_service_account" "this" {
  for_each     = var.list_serviceaccount
  account_id   = each.key
  display_name = each.value.description
}

data "google_iam_testable_permissions" "perms" {
    full_resource_name = "//cloudresourcemanager.googleapis.com/projects/my-project"
    stages             = ["GA", "BETA"]
    custom_support_level = "NOT_SUPPORTED"
}

# Create custom role based on given permissions
resource "google_project_iam_custom_role" "this" {
  for_each    = var.list_serviceaccount
  role_id     = replace("${each.key}-role", "-", "_")
  title       = "${each.key}'s service account role"
  permissions = compact([for x in concat(each.value.permissions, local.roles_permissions[each.key]) : contains(data.google_iam_testable_permissions.perms.permissions,x) ? "" : x])
}

# Bind role to service account
resource "google_project_iam_member" "this" {
  for_each = var.list_serviceaccount
  role     = google_project_iam_custom_role.this[each.key].id
  member   = "serviceAccount:${google_service_account.this[each.key].email}"
}

# Generate a key for needed service account
resource "google_service_account_key" "this" {
  for_each = {
    for k, v in var.list_serviceaccount : k => v
    if v.key == true
  }
  service_account_id = google_service_account.this[each.key].email
}
