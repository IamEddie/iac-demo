variable "project" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "isolated_subnet_ids" {
  type = list(string)
}

variable "lambda_role_arn" {
  type = string
}

variable "lambda_sg_id" {
  type = string
}

variable "private_lambda_zip_path" {
  type = string
}

variable "isolated_lambda_zip_path" {
  type = string
}

variable "lambda_handler" {
  type = string
}

variable "lambda_runtime" {
  type = string
}

variable "private_env" {
  type = map(string)
}

variable "isolated_env" {
  type = map(string)
}

variable "bucket_name" {
  type = string
}

variable "bucket_arn" {
  type = string
}

variable "kms_key_arn" {
  type = string
}

variable "wait_for_s3_endpoint" {
  type = bool
}
