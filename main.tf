provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "cloudcamp-terraform-state-jcv"
    key    = "workspaces_proyecto/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "cloudcamp-ddb-lock"
    encrypt = true
  }
}