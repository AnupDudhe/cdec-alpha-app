# Remote state: S3 + DynamoDB locking
#
# Initialize with:
#   cp backend.hcl.example backend.hcl   # edit bucket/region if needed
#   terraform init -backend-config=backend.hcl

terraform {
  backend "s3" {
    bucket  = "cdec-alpha-terraform-state-anup"
    key     = "frontend/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
    # profile = "terraform-sessions"

  }
}
