module "bucket" {
  source = "../.."

  name     = "shared-bucket"
  location = "EU"
  project  = "my-gcp-project"

  iam_members = {
    "roles/storage.objectViewer" = [
      "user:alice@example.com",
      "user:bob@example.com",
      "group:readers@example.com"
    ]
    "roles/storage.objectCreator" = [
      "serviceAccount:app-upload@my-gcp-project.iam.gserviceaccount.com"
    ]
    "roles/storage.objectAdmin" = [
      "serviceAccount:admin@my-gcp-project.iam.gserviceaccount.com"
    ]
  }

  labels = {
    type     = "shared"
    security = "restricted"
  }
}

output "bucket_name" {
  value = module.bucket.name
}
