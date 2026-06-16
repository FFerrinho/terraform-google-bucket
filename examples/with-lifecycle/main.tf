# Example 1: Transition to COLDLINE after 90 days
module "archive_bucket" {
  source = "../.."

  name     = "archive-bucket"
  location = "EU"
  project  = "my-gcp-project"

  storage_class = "STANDARD"
  versioning    = true

  enable_lifecycle_rule               = true
  lifecycle_rule_action_type          = "SetStorageClass"
  lifecycle_rule_action_storage_class = "COLDLINE"
  lifecycle_rule_condition_age        = 90
  lifecycle_rule_condition_with_state = "LIVE"
  lifecycle_rule_condition_num_newer_versions = 3

  labels = {
    type = "archive"
  }
}

# Example 2: Auto-delete objects after 30 days
module "temp_bucket" {
  source = "../.."

  name     = "temp-bucket"
  location = "europe-west1"
  project  = "my-gcp-project"

  enable_lifecycle_rule               = true
  lifecycle_rule_action_type          = "Delete"
  lifecycle_rule_condition_age        = 30
  lifecycle_rule_condition_with_state = "ANY"

  force_destroy = true

  labels = {
    type      = "temporary"
    retention = "30-days"
  }
}

# Example 3: Progressive tiering — move to NEARLINE after 30 days
module "tiered_bucket" {
  source = "../.."

  name     = "tiered-bucket"
  location = "EU"
  project  = "my-gcp-project"

  storage_class = "STANDARD"
  versioning    = false

  enable_lifecycle_rule               = true
  lifecycle_rule_action_type          = "SetStorageClass"
  lifecycle_rule_action_storage_class = "NEARLINE"
  lifecycle_rule_condition_age        = 30
  lifecycle_rule_condition_with_state = "LIVE"

  labels = {
    strategy = "progressive-tiering"
  }
}

output "archive_bucket" {
  value = module.archive_bucket.name
}

output "temp_bucket" {
  value = module.temp_bucket.name
}

output "tiered_bucket" {
  value = module.tiered_bucket.name
}
