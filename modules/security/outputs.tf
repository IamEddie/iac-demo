# security/outputs.tf
output "lambda_sg_id" { value = aws_security_group.lambda_sg.id }
output "lambda_role_arn" { value = aws_iam_role.lambda_role.arn }
