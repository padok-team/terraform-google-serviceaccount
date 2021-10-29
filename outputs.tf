output "service_account_private_key" {
  value     = { for k, v in var.list_serviceaccount : k => v.key == true ? google_service_account_key.this[k].private_key : null }
  sensitive = true
}

output "service_account_public_key" {
  value = { for k, v in var.list_serviceaccount : k => v.key == true ? google_service_account_key.this[k].public_key : null }
}

output "service_account_email" {
  value = { for k, v in var.list_serviceaccount : k => google_service_account.this[k].email }
}

output "test_debug_roles" {
  value = local.roles
}

output "test_debug_permissions" {
  value = local.roles_permissions
}
