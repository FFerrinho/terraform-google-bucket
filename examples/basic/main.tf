module "bucket" {
  source = "../.."

  name     = "my-basic-bucket"
  location = "europe-west1"
  project  = "my-gcp-project"

  labels = {
    environment = "development"
    team        = "engineering"
  }
}

output "bucket_name" {
  description = "Name of the created bucket"
  value       = module.bucket.name
}

output "bucket_url" {
  description = "URL of the bucket"
  value       = module.bucket.url
}
