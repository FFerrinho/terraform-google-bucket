variable "random_id" {
  description = "If a numeric random ID is to be used as suffix for resources names."
  type        = bool
  default     = true
}

variable "byte_length" {
  description = "The byte length for the random ID."
  type        = number
  default     = 2
}

variable "name" {
  description = "The name for the bucket."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{5,29}$", var.name))
    error_message = "The name must be a valid bucket name."
  }
}

variable "location" {
  description = "The location for the bucket."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{5,29}$", var.location))
    error_message = "The location must be a valid location ID."
  }
}

variable "project" {
  description = "The project for the bucket."
  type        = string

  validation {
    condition     = can(regex("^([a-z][-a-z0-9]{6,30}[a-z0-9])$", var.project))
    error_message = "The project must be a valid project ID."
  }
}

variable "force_destroy" {
  description = "Whether to force destroy the bucket."
  type        = bool
  default     = false
}

variable "storage_class" {
  description = "The storage class for the bucket."
  type        = string
  default     = "STANDARD"

  validation {
    condition     = can(regex("^(STANDARD|NEARLINE|COLDLINE|ARCHIVE)$", var.storage_class))
    error_message = "The storage class must be one of STANDARD, NEARLINE, COLDLINE, or ARCHIVE."
  }
}

variable "versioning" {
  description = "Whether to enable versioning for the bucket."
  type        = bool
  default     = false
}

variable "labels" {
  description = "A map of labels for the bucket."
  type        = map(string)
  default = {
    managed = "terraform"
  }
}

variable "uniform_bucket_level_access" {
  description = "Whether to enable uniform bucket-level access for the bucket."
  type        = bool
  default     = false
}

variable "public_access_prevention" {
  description = "Whether to enable public access prevention for the bucket."
  type        = string
  default     = "inherited"

  validation {
    condition     = can(regex("^(inherited|enforced)$", var.public_access_prevention))
    error_message = "The public access prevention must be one of inherited or enforced."
  }
}

variable "lifecycle_rule_action_type" {
  description = "The type for the lifecycle rule action."
  type        = string
  default     = "Delete"

  validation {
    condition     = can(regex("^(Delete|SetStorageClass)$", var.lifecycle_rule_action_type))
    error_message = "The lifecycle rule action type must be one of Delete or SetStorageClass."
  }
}

variable "lifecycle_rule_action_storage_class" {
  description = "The storage class for the lifecycle rule action."
  type        = string
  default     = "NEARLINE"

  validation {
    condition     = can(regex("^(STANDARD|NEARLINE|COLDLINE|ARCHIVE)$", var.lifecycle_rule_action_storage_class))
    error_message = "The lifecycle rule action storage class must be one of STANDARD, NEARLINE, COLDLINE, or ARCHIVE."
  }
}

variable "lifecycle_rule_condition_age" {
  description = "The age for the lifecycle rule condition."
  type        = number
  default     = 30
}

variable "lifecycle_rule_condition_created_before" {
  description = "The created before for the lifecycle rule condition."
  type        = string
  default     = "2019-01-01"
}

variable "lifecycle_rule_condition_is_live" {
  description = "The is live for the lifecycle rule condition."
  type        = bool
  default     = false
}

variable "lifecycle_rule_condition_num_newer_versions" {
  description = "The number of newer versions for the lifecycle rule condition."
  type        = number
  default     = 1
}
