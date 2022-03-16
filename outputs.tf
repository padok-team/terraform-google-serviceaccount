output "project_iam_custom_roles" {
  description = "A list of the created roles."
  value = [
    for r in google_project_iam_custom_role.this : r.name
  ]
}

output "keys" {
  description = "A map of each of the service accounts' keys."
  value = {
    for k, v in google_service_account_key.this : k => google_service_account_key.this[k].private_key
  }
  sensitive = true
}

output "emails" {
  description = "A map of each service accounts' emails."
  value = {
    for k, v in var.service_accounts : k => google_service_account.this[k].email
  }
}
