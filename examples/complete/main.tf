module "bucket" {
  source = "../.."

  # Basic configuration
  name          = "complete-bucket"
  location      = "EU"
  project       = "my-gcp-project"
  random_suffix = true
  byte_length   = 3
  force_destroy = false

  # Storage and versioning
  storage_class              = "STANDARD"
  versioning                 = true
  soft_delete_retention_days = 14

  # Security
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  # Bucket-level IAM
  iam_members = {
    "roles/storage.objectViewer" = [
      "group:readers@example.com"
    ]
    "roles/storage.objectAdmin" = [
      "serviceAccount:admin@my-gcp-project.iam.gserviceaccount.com"
    ]
  }

  # Managed folders with per-folder permissions
  folders = {
    "public-data" = {
      force_destroy = false
      permissions = {
        "roles/storage.objectViewer" = ["allAuthenticatedUsers"]
      }
    }
    "private-data" = {
      force_destroy = false
      permissions = {
        "roles/storage.objectViewer" = [
          "group:dev-team@example.com"
        ]
        "roles/storage.objectCreator" = [
          "serviceAccount:app@my-gcp-project.iam.gserviceaccount.com"
        ]
      }
    }
    "cold-archive" = {
      force_destroy = false
      permissions = {
        "roles/storage.objectAdmin" = [
          "serviceAccount:admin@my-gcp-project.iam.gserviceaccount.com"
        ]
      }
    }
  }

  # Lifecycle — move to COLDLINE after 180 days
  enable_lifecycle_rule               = true
  lifecycle_rule_action_type          = "SetStorageClass"
  lifecycle_rule_action_storage_class = "COLDLINE"
  lifecycle_rule_condition_age        = 180
  lifecycle_rule_condition_with_state = "LIVE"
  lifecycle_rule_condition_num_newer_versions = 5

  labels = {
    environment = "production"
    team        = "engineering"
    criticality = "high"
    compliance  = "gdpr"
  }
}
