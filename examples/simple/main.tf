module "bucket" {
  source = "../../"

  name     = "my-simple-bucket"
  location = "europe-west1"
  project  = "my-gcp-project"
}
