variable "vpc_id" {}
variable "ec2_sg_name" {}
variable "public_subnet_cidr_block" {}
variable "" {}

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