resource "aws_lambda_function" "private_lambda" {
  filename      = var.private_lambda_zip_path
  function_name = "${var.project}-private-lambda"
  role          = var.lambda_role_arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [var.lambda_sg_id]
  }

  environment {
    variables = var.private_env
  }
}

resource "aws_lambda_function" "isolated_lambda" {
  filename      = var.isolated_lambda_zip_path
  function_name = "${var.project}-isolated-lambda"
  role          = var.lambda_role_arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime

  vpc_config {
    subnet_ids         = var.isolated_subnet_ids
    security_group_ids = [var.lambda_sg_id]
  }

  environment {
    variables = merge(var.isolated_env, { BUCKET = var.bucket_name })
  }

  depends_on = [var.wait_for_s3_endpoint]
}

resource "aws_iam_policy" "isolated_lambda_s3_policy" {
  name = "${var.project}-isolated-lambda-s3"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        Resource = [var.bucket_arn, "${var.bucket_arn}/*"]
      },
      {
        Effect   = "Allow"
        Action   = ["kms:Encrypt", "kms:Decrypt", "kms:GenerateDataKey*", "kms:DescribeKey"]
        Resource = var.kms_key_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_isolated_policy" {
  role       = element(split("/", var.lambda_role_arn), length(split("/", var.lambda_role_arn)) - 1)
  policy_arn = aws_iam_policy.isolated_lambda_s3_policy.arn
}

