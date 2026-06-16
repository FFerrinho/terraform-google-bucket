resource "random_id" "main" {
  byte_length = var.byte_length
}

resource "google_storage_bucket" "main" {
  name                        = var.random_suffix == true ? "${var.name}-${random_id.main.dec}" : var.name
  location                    = var.location
  project                     = var.project
  force_destroy               = var.force_destroy
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access
  public_access_prevention    = var.public_access_prevention

  dynamic "cors" {
    for_each = toset(var.cors_enabled ? ["cors_block"] : [])
    content {
      origin          = var.cors_origins
      method          = var.cors_methods
      response_header = var.cors_response_headers
      max_age_seconds = var.cors_max_age_seconds
    }
  }

  soft_delete_policy {
    retention_duration_seconds = var.soft_delete_retention_days * 86400
  }

  versioning {
    enabled = var.versioning
  }

  dynamic "lifecycle_rule" {
    for_each = toset(var.enable_lifecycle_rule ? ["rule"] : [])
    content {
      action {
        type          = var.lifecycle_rule_action_type
        storage_class = var.lifecycle_rule_action_type == "SetStorageClass" ? var.lifecycle_rule_action_storage_class : null
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

resource "google_storage_managed_folder" "main" {
  for_each = var.folders

  bucket        = google_storage_bucket.main.name
  name          = each.key
  force_destroy = each.value.force_destroy
}
