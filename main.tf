resource "random_id" "main" {
  byte_length = var.byte_length
}

resource "google_storage_bucket" "main" {
  name                        = var.random_id == true ? "${var.name}-${random_id.main.dec}" : var.name
  location                    = var.location
  project                     = var.project
  force_destroy               = var.force_destroy
  storage_class               = var.storage_class
  labels                      = var.labels
  uniform_bucket_level_access = var.uniform_bucket_level_access
  public_access_prevention    = var.public_access_prevention

  versioning {
    enabled = var.versioning
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule_action_type == "" ? [] : [1]
    content {
      action {
        type          = var.lifecycle_rule_action_type
        storage_class = var.lifecycle_rule_action_storage_class
      }

      condition {
        age                = var.lifecycle_rule_condition_age
        created_before     = var.lifecycle_rule_condition_created_before
        is_live            = var.lifecycle_rule_condition_is_live
        num_newer_versions = var.lifecycle_rule_condition_num_newer_versions
      }
    }
  }
}
