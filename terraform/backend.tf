terraform {
  backend "s3" {
    bucket = "my-terraform-backend-bucket"
    key    = "path/to/my/key"
    region = "eu-central-1"
    # encrypt = true
    # Ensure you have AWS credentials configured for this to work.
  }
}
