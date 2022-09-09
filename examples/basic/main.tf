locals {
  project_id = "library-344516"
}

resource "google_secret_manager_secret" "secret-basic" {
  project   = local.project_id
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
  project  = local.project_id
  name     = "bucket-basic"
  location = "US"
}

module "test_sa" {
  source       = "../.."
  name         = "test-sa-new"
  project_id   = local.project_id
  display_name = "Service Account to test Terraform module"

  project_roles = {
    library-storage-admin = {
      resources = [local.project_id]
      roles = ["roles/storage.admin"]
    }
  }
  # Should pass name of bucket
  bucket_roles = {
    bucket-basic-admin = {
      resources = [google_storage_bucket.bucket-basic.name]
      roles = ["roles/storage.admin"]
    }
  }
  # Should pass id output of secret resource
  secret_roles = {
    secret-basic = {
      resources = [google_secret_manager_secret.secret-basic.id]
      roles = ["roles/secretmanager.secretAccessor"]
    }
  }
  # Should pass name/id output of service_account resource
  service_account_roles = {
    sa = {
      resources = []
      roles = []
    }
  }
  # Generic membership, you can set any role you need on this service account for anything you'd like
  # For instance this represent what would be done if we wanted to use the same setup as kubernetes_members to grant a K8S SA access to this SA
  members = {
    example = {
      entities = ["serviceAccount:padok-playground.svc.id.goog[system/playground-operator]"]
      roles = ["roles/iam.workloadIdentityUser"]
    }
  }
  # workload_identity_pool can be obtained through the output of the GKE module
  kubernetes_members = {
    playground-operator = {
      workload_identity_pool = "padok-playground.svc.id.goog"
      namespace              = "system"
      name                   = "playground-operator"
  }}
}
