output "name" {
  description = "The name of the bucket."
  value       = google_storage_bucket.main.name
}

output "self_link" {
  description = "The URI of the created resource."
  value       = google_storage_bucket.main.self_link
}

output "url" {
  description = "The bucket's website URL."
  value       = google_storage_bucket.main.url
}

output "managed_folders" {
  description = "List of managed folder names created in the bucket."
  value       = [for folder in google_storage_managed_folder.main : folder.name]
}

output "bucket_iam_bindings" {
  description = "Map of IAM roles to members assigned at the bucket level."
  value = var.iam_members != null ? {
    for role, members in var.iam_members : role => members
  } : {}
}

output "folder_iam_bindings" {
  description = "Map of IAM roles and members assigned per managed folder (key: folder:role)."
  value = {
    for key, binding in local.folder_role_members : key => {
      folder  = binding.folder
      role    = binding.role
      members = binding.members
    }
  }
}
