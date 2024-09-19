terraform {
  backend "s3" {
    bucket = "terra-state-store-bucket"
    key = "state/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_table = "terraform_lock"
  }
}