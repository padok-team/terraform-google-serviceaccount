output "project_iam_custom_roles" {
  description = "Custom roles for the project"
  value = toset([
    for r in google_project_iam_custom_role.this : r.name
  ])
}

output "service_account_keys" {
  description = "Service account keys"
  value = toset([
    for k in google_service_account_key.this : k.private_key
  ])
  sensitive = true
}

output "service_account_emails" {
  description = "Service account emails"
  value = {
    for k, v in var.service_accounts : k => google_service_account.this[k].email
  }
}
