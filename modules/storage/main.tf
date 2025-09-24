# storage/main.tf
data "aws_caller_identity" "current" {}


resource "aws_kms_key" "s3_key" {
  description             = "KMS key for S3 bucket"
  deletion_window_in_days = 30
}


resource "aws_s3_bucket" "sensitive" {
  bucket = "${var.project}-sensitive-${data.aws_caller_identity.current.account_id}-${substr(md5(timestamp()), 0, 6)}"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.s3_key.arn
      }
    }
  }
  force_destroy = true
  tags          = { Name = "${var.project}-sensitive-bucket" }
}


resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.sensitive.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
