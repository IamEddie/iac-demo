# storage/outputs.tf
output "bucket_name" { value = aws_s3_bucket.sensitive.bucket }
output "bucket_arn" { value = aws_s3_bucket.sensitive.arn }
output "kms_key_arn" { value = aws_kms_key.s3_key.arn }