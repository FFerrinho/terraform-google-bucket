module "bucket" {
  source = "../.."

  name     = "organized-bucket"
  location = "europe-west1"
  project  = "my-gcp-project"

  folders = {
    # Public folder — read access for all
    "public-documents" = {
      force_destroy = false
      permissions = {
        "roles/storage.objectViewer" = ["allUsers"]
      }
    }

    # Team folder — restricted access
    "dev-team" = {
      force_destroy = true
      permissions = {
        "roles/storage.objectViewer" = [
          "group:dev-team@example.com"
        ]
        "roles/storage.objectCreator" = [
          "group:dev-team@example.com"
        ]
      }
    }

    # Archive folder — admins only
    "archive" = {
      force_destroy = false
      permissions = {
        "roles/storage.objectAdmin" = [
          "serviceAccount:admin@my-gcp-project.iam.gserviceaccount.com"
        ]
      }
    }

    # Scratch folder — inherits bucket-level permissions
    "scratch" = {
      force_destroy = true
      permissions   = {}
    }
  }

  labels = {
    organization = "by-folder"
    environment  = "production"
  }
}

output "bucket_name" {
  value = module.bucket.name
}

output "managed_folders" {
  value = module.bucket.managed_folders
}
