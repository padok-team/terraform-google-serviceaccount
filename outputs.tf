output "email" {
  value = google_service_account.this.email
}

output "service_account_public_key" {
  value = var.create_key == true ? google_service_account_key.this[*].public_key : null
}

output "service_account_private_key" {
  value     = var.create_key == true ? google_service_account_key.this[*].private_key : null
  sensitive = true
}
