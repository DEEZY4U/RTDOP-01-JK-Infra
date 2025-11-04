variable "lb_name" {}
variable "lb_type" {}
variable "is_external" { default = false }
variable "sg_enable_ssh_http" {}
variable "subnet_id" {}
variable "tag_name" {}
variable "lb_target_group_arn" {}
# variable "ec2_instance_id" {}
variable "lb_listener_port" {}
variable "lb_listener_protocol" {}
variable "lb_https_listener_port" {}
variable "lb_https_listener_protocol" {}
variable "lb_listener_default_action" {}
variable "dev_rtdop_01_acm_arn" {}
# variable "lb_target_group_attachment_port" {}

output "aws_lb_dns_name" {
  value = aws_lb.dev_rtdop_01_lb.dns_name
}

output "aws_lb_zone_id" {
  value = aws_lb.dev_rtdop_01_lb.zone_id
}

resource "aws_lb" "dev_rtdop_01_lb" {
  name = var.lb_name
  internal = var.is_external
  load_balancer_type = var.lb_type
  security_groups = [ var.sg_enable_ssh_http ]
  subnets = var.subnet_id
  enable_deletion_protection = false

  tags = {
    Name = "app-lb"
  }
}

resource "aws_lb_listener" "dev_rtdop_01_listener" {
  load_balancer_arn = aws_lb.dev_rtdop_01_lb.arn
  port = var.lb_listener_port
  protocol = var.lb_listener_protocol

  default_action {
    type = var.lb_listener_default_action
    target_group_arn = var.lb_target_group_arn
  }
}

resource "aws_lb_listener" "dev_rtdop_01_lb_https_listner" {
  load_balancer_arn = aws_lb.dev_rtdop_01_lb.arn
  port              = var.lb_https_listener_port
  protocol          = var.lb_https_listener_protocol
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = var.dev_rtdop_01_acm_arn

  default_action {
    type             = var.lb_listener_default_action
    target_group_arn = var.lb_target_group_arn
  }
}