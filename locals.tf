locals {
  # Concatenate all roles contained in all given service accounts
  # Excluding blacklisted roles contained in local.roles_blacklist
  # Renders a list of roles e.g. ["roles/apigateway.admin", "roles/cloudbuild.builds.builder"]
  roles = flatten([
    for k, v in var.service_accounts :
    [
      for role in v.roles : role if !contains(local.roles_blacklist, role)
    ]
    ])

  # Create a map with the serviceAccount name as Key and the list of permissions resulting from the merge of
  # All permissions in each role excluding permissions from local.roles_blacklist
  # Renders a map like this : {
  #  "my-first-sa": ["workflows.locations.get","workflows.locations.list"],
  #  "my-second-sa": ["workflows.locations.get","workflows.locations.list"]
  # }
  permissions = {
    for k, v in var.service_accounts : k => flatten([for r in [for role in v.roles :
    role if !contains(local.roles_blacklist, role)] : [flatten(data.google_iam_role.roles[r].included_permissions)]])
  }

  # Create a list of maps keeping the name of the service account and excluded predefined role for for_each purposes
  # Renders a list like this : [{"name": "my-first-sa", "role": "roles/editor"}]
  # This is mandatory to iterate recursively other 2 things (ServiceAccounts and the roles for each serviceAccount)
  predefined_roles = flatten(
    [
      for k, v in var.service_accounts :
    [
      for role in v.roles : {
      name = k
      role = role
      } if contains(local.roles_blacklist, role)
    ]
    ])

  # Regex used to remove organization specific permissions
  organization_permissions = "^(billing|securitycenter|earlyaccesscenter|riskmanager|compute\\.organizations|chroniclesm|cloudsupport|consumerprocurement|cloudprivatecatalogproducer|accesscontextmanager|assuredworkloads|resourcemanager|orgpolicy|commerceoffercatalog).*$"

  # List of blacklisted roles because their number of permissions is too large
  # If they are present in the service_accounts variable they will be added to the serviceAccount directly
  roles_blacklist = ["roles/iam.securityAdmin",
                     "roles/editor",
                     "roles/owner",
                     "roles/viewer",
                     "roles/composer.serviceAgent",
                     "roles/container.serviceAgent"]

  # List of excluded permissions that can't be added at project level
  excluded_permissions = concat(
    [for k, v in data.google_iam_testable_permissions.unsupported.permissions : v.name],
    [
      "compute.securityPolicies.copyRules",
      "compute.securityPolicies.move",
      "compute.securityPolicies.removeAssociation",
      "compute.securityPolicies.addAssociation",
      "compute.firewallPolicies.copyRules",
      "compute.firewallPolicies.removeAssociation",
      "compute.firewallPolicies.addAssociation",
      "compute.firewallPolicies.move",
      "compute.oslogin.updateExternalUser",
    ])
}
