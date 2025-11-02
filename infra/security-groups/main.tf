variable "vpc_id" {}
variable "ec2_sg_name" {}
variable "public_subnet_cidr_block" {}
variable "ec2_sg_rds_name" {}
variable "ec2_sg_python_app" {}

output "sg_ec2_sg_ssh_https_id" {
  value = aws_security_group.ec2_sg_ssh_http.id
}

output "sg_ec2_sg_rds_id" {
  value = aws_security_group.rds_sg.id
}

output "sg_ec2_python_app_id" {
  value = aws_security_group.ec2_sg_python_app_port.id
}

resource "aws_security_group" "ec2_sg_ssh_http" {
  name = var.ec2_sg_name
  description = "Enable the ports 22, 80 & 443"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow SSH from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  ingress {
    description = "Allow HTTP from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }

  ingress {
    description = "Allow HTTPS from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }

  egress {
    description = "Allow outgoing requests"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }

  tags = {
    Name = "Security Group to allow SS, HTTP, & HTTPS"
  }
}

resource "aws_security_group" "rds_sg" {
  name = var.ec2_sg_rds_name
  description = "Allow access to RDS"
  vpc_id = var.vpc_id

  ingress {
    cidr_blocks = var.public_subnet_cidr_block
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
  }

  tags = {
    Name = "Security Group to allow traffic on 3306"
  }
}

resource "aws_security_group" "ec2_sg_python_app_port" {
  name = var.ec2_sg_python_app
  description = "Enable port for 5000"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow traffic on port 5000"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
  }

  tags = {
    Name = "Security Group to allow traffic on port 5000"
  }
}