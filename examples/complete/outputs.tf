output "bucket_name" {
  description = "Full name of the created bucket (including random suffix)."
  value       = module.bucket.name
}

output "bucket_url" {
  description = "URL of the created bucket."
  value       = module.bucket.url
}

output "bucket_self_link" {
  description = "Full URI of the created resource."
  value       = module.bucket.self_link
}

output "managed_folders" {
  description = "List of managed folders created in the bucket."
  value       = module.bucket.managed_folders
}
