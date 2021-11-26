data "google_iam_role" "roles" {
  for_each = toset(local.roles)
  name = each.value
}

data "google_project" "project" {
}

locals {
  roles = flatten([for k,v in var.list_serviceaccount : v.roles])

  roles_permissions = {
    for k, v in var.list_serviceaccount : k => flatten([for r in v.roles : [flatten(data.google_iam_role.roles[r].included_permissions)]])
  }

  organization_permissions = "^(securitycenter|earlyaccesscenter|riskmanager|compute\\.organizations|chroniclesm|cloudsupport|consumerprocurement|cloudprivatecatalogproducer|accesscontextmanager|assuredworkloads|resourcemanager|orgpolicy|commerceoffercatalog).*$"
  list_of_excluded_permissions =  concat(
    [for k,v in data.google_iam_testable_permissions.unsupported.permissions : v.name],
    [
    "compute.securityPolicies.copyRules",
    "compute.securityPolicies.move",
    "compute.securityPolicies.removeAssociation",
    "compute.securityPolicies.addAssociation",
    "resourcemanager.projects.list",
    "resourcemanager.projects.get",
    "compute.firewallPolicies.copyRules",
    "compute.firewallPolicies.removeAssociation",
    "compute.firewallPolicies.addAssociation",
    "compute.firewallPolicies.move",
    "compute.oslogin.updateExternalUser",
    "billing.resourceAssociations.list"])
}

# Create service account
resource "google_service_account" "this" {
  for_each     = var.list_serviceaccount
  account_id   = each.key
  display_name = each.value.description
}

data "google_iam_testable_permissions" "unsupported" {
  full_resource_name = "//cloudresourcemanager.googleapis.com/projects/${data.google_project.project.name}"
  stages = ["ALPHA","BETA","GA","DEPRECATED"]
  custom_support_level = "NOT_SUPPORTED"
}

# Create custom role based on given permissions
resource "google_project_iam_custom_role" "this" {
  for_each    = var.list_serviceaccount
  role_id     = replace("${each.key}-role", "-", "_")
  title       = "${each.key}'s service account role"
  permissions = compact([for x in concat(each.value.permissions, local.roles_permissions[each.key]) :
  contains(local.list_of_excluded_permissions,x) || length(regexall(local.organization_permissions, x)) > 0 ? "" : x])
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
