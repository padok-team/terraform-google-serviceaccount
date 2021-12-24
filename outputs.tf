output "custom_roles" {
  value = toset([
    for r in google_project_iam_custom_role.this : r.name
  ])
}

output "keys" {
  value = toset([
    for k in google_service_account_key.this : k.private_key
  ])
  sensitive = true
}
