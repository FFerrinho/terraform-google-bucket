resource "random_id" "main" {
  byte_length = var.byte_length
}

resource "google_storage_bucket" "main" {
  name                        = var.random_id == true ? "${var.name}-${random_id.main.dec}" : var.name
  location                    = var.location
  project                     = var.project
  force_destroy               = var.force_destroy
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access
  public_access_prevention    = var.public_access_prevention

  soft_delete_policy {
    retention_duration_seconds = var.soft_delete_policy_retention_duration_seconds
  }

  versioning {
    enabled = var.versioning
  }

  dynamic "lifecycle_rule" {
    for_each = toset(var.enable_lifecycle_rule ? ["rule"] : [])
    content {
      action {
        type          = var.lifecycle_rule_action_type
        storage_class = var.lifecycle_rule_action_storage_class
      }

      condition {
        age                = var.lifecycle_rule_condition_age
        created_before     = var.lifecycle_rule_condition_created_before
        with_state         = var.lifecycle_rule_condition_with_state
        num_newer_versions = var.lifecycle_rule_condition_num_newer_versions
      }
    }
  }

  labels = merge(
    var.labels,
    {
      managed = "terraform"
    }
  )
}
