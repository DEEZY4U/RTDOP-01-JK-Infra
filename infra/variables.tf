variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR values"
}

variable "vpc_name" {
  type        = string
  description = "RTDOP 01 VPC"
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "Private Subnet CIDR values"
}

variable "us_east_az" {
  type        = list(string)
  description = "Availability Zones"
}