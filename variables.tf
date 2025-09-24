variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "isolated_subnet_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "project" {
  type = string
}

variable "az" {
  type = string
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "account_id" {
  type = string
}