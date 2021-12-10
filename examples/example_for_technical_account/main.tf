provider "google" {
  project = "padok-cloud-factory"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

# Create services account for machine

module "service_account" {
  source = "../.."
  list_serviceaccount = {
    "my-first-sa" = {
      permissions = [
        "iam.roles.create",
        "iam.roles.delete",
        "iam.roles.undelete",
        "iam.roles.get",
        "iam.roles.list"
      ]
      roles = [
    "roles/apigateway.admin",
    "roles/cloudbuild.builds.builder",
    "roles/cloudfunctions.admin",
    "roles/cloudsql.admin",
    "roles/compute.admin",
    "roles/container.admin",
    "roles/dns.admin",
    "roles/firebase.admin",
    "roles/firebasestorage.admin",
    "roles/logging.admin",
    "roles/monitoring.admin",
    "roles/networkmanagement.admin",
    "roles/pubsub.admin",
    "roles/redis.admin",
    "roles/run.admin",
    "roles/secretmanager.admin",
    "roles/securitycenter.admin",
    "roles/storage.admin",
    "roles/vpcaccess.admin",
    "roles/iap.admin",
    "roles/iam.securityAdmin",
    "roles/iap.httpsResourceAccessor"]
      description      = "Service account for managing IAM roles"
      key              = false
    }
    "my-second-sa" = {
      permissions = [
        "cloudsql.instances.get",
        "cloudsql.instances.login"
      ]
      roles = []
      description      = "Service account for Cloud SQL Instance"
      key              = true
    }
  }
}

# output "service_account_private_key" {
#   value     = module.service_account.service_account_private_key
#   sensitive = true
# }

# output "service_account_public_key" {
#   value = module.service_account.service_account_public_key
# }

# output "service_account_email" {
#   value = module.service_account.service_account_email
# }

output "member_roles" {
  value = module.service_account.member_roles
}

output "roles" {
  value = module.service_account.roles
}
