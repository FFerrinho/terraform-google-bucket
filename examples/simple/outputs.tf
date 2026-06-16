output "bucket_name" {
  description = "Name of the created bucket."
  value       = module.bucket.name
}

output "bucket_url" {
  description = "URL of the created bucket."
  value       = module.bucket.url
}
