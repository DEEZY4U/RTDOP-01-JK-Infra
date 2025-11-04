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

variable "ami_id" {
  type        = string
  description = "AMI Id for EC2 instance"
}

variable "key_name" {
  type        = string
  description = "Key Name for EC2"
}

variable "public_key" {
  type        = string
  description = "Public key for EC2 instance"
}

variable "domain_name" {
  type        = string
  description = "Domain Name for application"
}