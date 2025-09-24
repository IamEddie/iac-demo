output "public_api_url" {
  value = "https://${aws_api_gateway_rest_api.public_api.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.public_stage.stage_name}"
}

output "public_api_deployment_id" {
  value = aws_api_gateway_deployment.public_deploy.id
}

output "public_api_execution_arn" {
  value = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.public_api.id}/*"
}
