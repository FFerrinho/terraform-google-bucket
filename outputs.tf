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
