variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "public_key" {}
variable "tag_name" {}
variable "subnet_id" {}
variable "sg_enable_ssh_http" {}
variable "sg_enable_app_port" {}
variable "enable_public_id" {}
variable "user_data_install_apache" {}

output "ssh_connection_for_ec2" {
  value = format("%s%s", "ssh -i /home/deezy/.ssh/${var.key_name} ubuntu@", aws_instance.dev_rtdop_01_ec2.public_ip)
}

output "dev_rtdop_01_ec2_instance_id" {
  value = aws_instance.dev_rtdop_01_ec2.id
}

resource "aws_instance" "dev_rtdop_01_ec2" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = [ var.sg_enable_ssh_http, var.sg_enable_app_port ]
  associate_public_ip_address = var.enable_public_id

  user_data = var.user_data_install_apache

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }

  tags = {
    Name = var.tag_name
  }
}

resource "aws_key_pair" "dev_rtdop_01_public_key" {
  key_name = var.key_name
  public_key = var.public_key
}