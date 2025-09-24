provider "aws" { region = "us-east-1" }
data "aws_caller_identity" "current" {}

resource "random_id" "bucket_id" { byte_length = 4 }

# Example S3 + KMS
resource "aws_s3_bucket" "example" {
  bucket        = "demo-sensitive-bucket-${random_id.bucket_id.hex}"
  force_destroy = true
}

resource "aws_kms_key" "example" {
  description             = "KMS key for Lambda S3 access"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

# VPC
module "vpc" {
  source                 = "./modules/vpc"
  project                = "demo"
  vpc_cidr               = "10.0.0.0/16"
  azs                    = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs    = { "a" = "10.0.1.0/24", "b" = "10.0.2.0/24" }
  private_subnet_cidrs   = { "a" = "10.0.11.0/24", "b" = "10.0.12.0/24" }
  isolated_subnet_cidrs  = { "a" = "10.0.21.0/24", "b" = "10.0.22.0/24" }
  public_subnet_az_map   = { "a" = 0, "b" = 1 }
  private_subnet_az_map  = { "a" = 0, "b" = 1 }
  isolated_subnet_az_map = { "a" = 0, "b" = 1 }
}

# Lambda
module "lambda" {
  source                   = "./modules/lambda"
  project                  = "demo"
  private_subnet_ids       = module.vpc.private_subnet_ids
  isolated_subnet_ids      = module.vpc.isolated_subnet_ids
  lambda_role_arn          = "<your-lambda-role-arn>"
  lambda_sg_id             = "<your-lambda-sg-id>"
  private_lambda_zip_path  = "./packages/private_lambda.zip"
  isolated_lambda_zip_path = "./packages/isolated_lambda.zip"
  lambda_handler           = "handler.lambda_handler"
  lambda_runtime           = "python3.11"
  private_env              = {}
  isolated_env             = {}
  bucket_name              = aws_s3_bucket.example.bucket
  bucket_arn               = aws_s3_bucket.example.arn
  kms_key_arn              = aws_kms_key.example.arn
  wait_for_s3_endpoint     = true
}

# API Gateway
module "api_gateway" {
  source            = "./modules/api-gateway"
  project           = "demo"
  lambda_invoke_arn = module.lambda.private_lambda_arn
  region            = "us-east-1"
  account_id        = data.aws_caller_identity.current.account_id
}
