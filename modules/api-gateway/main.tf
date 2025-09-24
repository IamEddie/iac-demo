resource "aws_api_gateway_rest_api" "public_api" {
  name = "${var.project}-api"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.public_api.id
  parent_id   = aws_api_gateway_rest_api.public_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "any" {
  rest_api_id   = aws_api_gateway_rest_api.public_api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id             = aws_api_gateway_rest_api.public_api.id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = aws_api_gateway_method.any.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_deployment" "public_deploy" {
  rest_api_id = aws_api_gateway_rest_api.public_api.id
  depends_on  = [aws_api_gateway_integration.lambda]
}

resource "aws_api_gateway_stage" "public_stage" {
  deployment_id = aws_api_gateway_deployment.public_deploy.id
  rest_api_id   = aws_api_gateway_rest_api.public_api.id
  stage_name    = "prod"
}
