variable "random_suffix" {
  description = "Whether to append a random numeric ID as a suffix to the bucket name."
  type        = bool
  default     = true
}

variable "byte_length" {
  description = "The byte length for the random suffix (1-4 bytes)."
  type        = number
  default     = 2
}

variable "name" {
  description = "The base name for the bucket."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{5,29}$", var.name))
    error_message = "The name must be a valid bucket name."
  }
}

variable "location" {
  description = "The bucket location (e.g. europe-west1, us-central1, dual-region EUR4, or multi-region EU/US)."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z][A-Za-z0-9-]{1,29}$", var.location))
    error_message = "The location must be a valid GCS location ID (e.g. europe-west1, EU, EUR4)."
  }
}

variable "project" {
  description = "The GCP project ID."
  type        = string

  validation {
    condition     = can(regex("^([a-z][-a-z0-9]{6,30}[a-z0-9])$", var.project))
    error_message = "The project must be a valid GCP project ID."
  }
}

variable "force_destroy" {
  description = "Whether to allow bucket deletion even when it contains objects."
  type        = bool
  default     = false
}

variable "storage_class" {
  description = "The storage class: STANDARD, NEARLINE, COLDLINE, or ARCHIVE."
  type        = string
  default     = "STANDARD"

  validation {
    condition     = can(regex("^(STANDARD|NEARLINE|COLDLINE|ARCHIVE)$", var.storage_class))
    error_message = "The storage class must be one of STANDARD, NEARLINE, COLDLINE, or ARCHIVE."
  }
}

variable "versioning" {
  description = "Whether to enable object versioning."
  type        = bool
  default     = false
}

variable "labels" {
  description = "A map of labels to apply to the bucket."
  type        = map(string)
  default     = null
}

variable "uniform_bucket_level_access" {
  description = "Whether to enable uniform bucket-level access (recommended)."
  type        = bool
  default     = true
}

variable "public_access_prevention" {
  description = "Public access prevention policy: inherited, enforced, or null (to allow public access)."
  type        = string
  default     = "enforced"

  validation {
    condition     = var.public_access_prevention == null || can(regex("^(inherited|enforced)$", var.public_access_prevention))
    error_message = "The public access prevention must be inherited, enforced, or null."
  }
}

variable "soft_delete_retention_days" {
  description = "Soft delete retention duration in days. Use 0 to disable, or 7-90 for a valid retention period."
  type        = number
  default     = 7

  validation {
    condition     = var.soft_delete_retention_days == 0 || (var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90)
    error_message = "soft_delete_retention_days must be 0 (to disable) or between 7 and 90."
  }
}

variable "enable_lifecycle_rule" {
  description = "Whether to enable a lifecycle rule on the bucket."
  type        = bool
  default     = false
}

variable "lifecycle_rule_action_type" {
  description = "Lifecycle rule action type: Delete or SetStorageClass."
  type        = string
  default     = "Delete"

  validation {
    condition     = can(regex("^(Delete|SetStorageClass)$", var.lifecycle_rule_action_type))
    error_message = "The lifecycle rule action type must be Delete or SetStorageClass."
  }
}

variable "lifecycle_rule_action_storage_class" {
  description = "Target storage class when lifecycle_rule_action_type is SetStorageClass."
  type        = string
  default     = "NEARLINE"

  validation {
    condition     = can(regex("^(STANDARD|NEARLINE|COLDLINE|ARCHIVE)$", var.lifecycle_rule_action_storage_class))
    error_message = "The lifecycle rule action storage class must be one of STANDARD, NEARLINE, COLDLINE, or ARCHIVE."
  }
}

variable "lifecycle_rule_condition_age" {
  description = "Minimum object age in days before the lifecycle rule applies."
  type        = number
  default     = 30
}

variable "lifecycle_rule_condition_created_before" {
  description = "Apply the lifecycle rule only to objects created before this date (YYYY-MM-DD)."
  type        = string
  default     = "2019-01-01"
}

variable "lifecycle_rule_condition_with_state" {
  description = "Object state to match: LIVE, ARCHIVED, or ANY."
  type        = string
  default     = "ANY"

  validation {
    condition     = can(regex("^(LIVE|ARCHIVED|ANY)$", var.lifecycle_rule_condition_with_state))
    error_message = "The lifecycle rule condition with_state must be LIVE, ARCHIVED, or ANY."
  }
}

variable "lifecycle_rule_condition_num_newer_versions" {
  description = "Number of newer versions to keep when versioning is enabled."
  type        = number
  default     = 1
}

variable "iam_members" {
  description = "Map of IAM roles to lists of members (user:, group:, serviceAccount:)."
  type        = map(list(string))
  default     = {}

  validation {
    condition = var.iam_members == null || alltrue([
      for role in keys(var.iam_members) : can(regex("^roles/", role))
    ])
    error_message = "All IAM roles must start with 'roles/'."
  }
}

variable "folders" {
  description = "Map of managed folder names to create in the bucket, with optional force_destroy and IAM permissions."
  type = map(object({
    force_destroy = optional(bool, false)
    permissions   = optional(map(list(string)), {})
  }))
  default = {}
}

variable "cors_enabled" {
  description = "Whether to configure CORS on the bucket."
  type        = bool
  default     = false
}

variable "cors_origins" {
  description = "List of origins allowed for CORS requests."
  type        = list(string)
  default     = [""]
}

variable "cors_methods" {
  description = "List of HTTP methods allowed for CORS requests."
  type        = list(string)
  default     = ["GET", "HEAD", "PUT", "POST", "DELETE"]
}

variable "cors_response_headers" {
  description = "List of response headers to expose for CORS requests."
  type        = list(string)
  default     = ["*"]
}

variable "cors_max_age_seconds" {
  description = "Maximum number of seconds the browser can cache a preflight CORS response."
  type        = number
  default     = 3600
}
