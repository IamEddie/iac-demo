terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "s3state-remote-backend"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dynamodb-tfstate-locking"
    encrypt        = true
  }
}