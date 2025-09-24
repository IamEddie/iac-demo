# security/main.tf
resource "aws_security_group" "lambda_sg" {
  name        = "${var.project}-lambda-sg"
  vpc_id      = var.vpc_id
  description = "Security group for Lambda functions"


  # Allow outbound to S3 endpoints and AWS services
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = { Name = "${var.project}-lambda-sg" }
}


# IAM role for Lambdas (basic execution)
resource "aws_iam_role" "lambda_role" {
  name = "${var.project}-lambda-exec-role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{ Effect = "Allow", Principal = { Service = "lambda.amazonaws.com" }, Action = "sts:AssumeRole" }]
  })
}


resource "aws_iam_policy" "lambda_logging" {
  name = "${var.project}-lambda-logging"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      { Effect = "Allow", Action = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"], Resource = "arn:aws:logs:*:*:*" }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "attach_logging" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}
