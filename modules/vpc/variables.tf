variable "project" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = map(string)
}

variable "private_subnet_cidrs" {
  type = map(string)
}

variable "isolated_subnet_cidrs" {
  type = map(string)
}

variable "public_subnet_az_map" {
  type = map(number)
}

variable "private_subnet_az_map" {
  type = map(number)
}

variable "isolated_subnet_az_map" {
  type = map(number)
}
