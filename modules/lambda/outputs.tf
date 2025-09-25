output "private_lambda_arn" { 
    value = aws_lambda_function.private_lambda.arn 
}

output "isolated_lambda_arn" { 
    value = aws_lambda_function.isolated_lambda.arn 
}
