# Required to get unsupported permissions
data "google_project" "project" {
}

# Datasource to get permissions from all given roles
data "google_iam_role" "roles" {
  for_each = toset(local.roles)
  name     = each.value
}

# Datasource to get unsupported permissions based on project name
data "google_iam_testable_permissions" "unsupported" {
  full_resource_name   = "//cloudresourcemanager.googleapis.com/projects/${data.google_project.project.name}"
  stages               = ["ALPHA", "BETA", "GA", "DEPRECATED"]
  custom_support_level = "NOT_SUPPORTED"
}

# Create service account
resource "google_service_account" "this" {
  for_each     = var.service_accounts
  account_id   = each.key
  display_name = each.value.description
}

# Create custom role based on given permissions
resource "google_project_iam_custom_role" "this" {
  for_each = {
    for k, v in var.service_accounts : k => v
    if v.permissions != null || v.roles != null
  }
  role_id = replace("${each.key}-role", "-", "_")
  title   = "${each.key}'s service account role"
  permissions = compact([
    for x in concat(
      lookup(var.service_accounts[each.key], "permissions", null) == null ? [] : var.service_accounts[each.key].permissions,
      lookup(local.permissions, each.key, [])) :
        contains(local.excluded_permissions, x) || length(regexall(local.organization_permissions, x)) > 0 ? "" : x
  ])
}

# Bind blacklisted roles directly without including them in the custom role
resource "google_project_iam_member" "blacklisted_roles" {
  project = data.google_project.project.id
  for_each = {
    for value in local.predefined_roles : "${value.name}-${value.role}" => value
  }
  role   = each.value.role
  member = "serviceAccount:${google_service_account.this[each.value.name].email}"
}

# Bind custom role to serviceAccount
resource "google_project_iam_member" "this" {
  project = data.google_project.project.id
  for_each = {
    for k, v in var.service_accounts : k => v
    if v.permissions != null || v.roles != null
  }
  role   = google_project_iam_custom_role.this[each.key].id
  member = "serviceAccount:${google_service_account.this[each.key].email}"
}

# Generate a key for needed service account
resource "google_service_account_key" "this" {
  for_each = {
    for k, v in var.service_accounts : k => v
    if v.key == true
  }
  service_account_id = google_service_account.this[each.key].email
}
