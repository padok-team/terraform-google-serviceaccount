resource "google_secret_manager_secret" "secret-basic" {
  project   = "library-344516"
  secret_id = "secret"
  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }
      replicas {
        location = "us-east1"
      }
    }
  }
}

resource "google_storage_bucket" "bucket-basic" {
  # All those rules are not relevant for this example
  #checkov:skip=CKV_GCP_78:Ensure Cloud storage has versioning enabled
  #checkov:skip=CKV_GCP_29:Ensure that Cloud Storage buckets have uniform bucket-level access enabled
  #checkov:skip=CKV_GCP_114:Ensure public access prevention is enforced on Cloud Storage bucket
  #checkov:skip=CKV_GCP_62:Bucket should log access
  project  = "library-344516"
  name     = "bucket-basic"
  location = "US"
}

module "test_sa" {
  source       = "../.."
  name         = "test-sa-new"
  project_id   = "library-344516"
  display_name = "Service Account to test Terraform module"

  # Should pass name of project
  project_roles = [
    "roles/storage.admin"
  ]
  external_project_roles = [
    "padok-playground=>roles/storage.admin"
  ]
  # Should pass name of bucket
  bucket_roles = [
    "${google_storage_bucket.bucket-basic.name}=>roles/storage.admin"
  ]
  # Should pass secret_id output of secret resource
  secret_roles = [
    "projects/library-344516/secrets/${google_secret_manager_secret.secret-basic.secret_id}=>roles/secretmanager.secretAccessor"
  ]
  # Should pass name/id output of service_account resource
  service_account_roles = []
  members = [
    "serviceAccount:padok-playground.svc.id.goog[system/playground-operator]=>roles/iam.workloadIdentityUser"
  ]
}
