variable "domain_name" {}
variable "aws_lb_dns_name" {}
variable "aws_lb_zone_id" {}

output "hosted_zone_id" {
  value = data.aws_route53_zone.dev_rtdop_01_app_domain_name.zone_id
}

data "aws_route53_zone" "dev_rtdop_01_app_domain_name" {
  name = "deezyboi.space"
  private_zone = false
}

resource "aws_route53_record" "lb_record" {
  zone_id = data.aws_route53_zone.dev_rtdop_01_app_domain_name.zone_id
  name = var.domain_name
  type = "A"

  alias {
    name = var.aws_lb_dns_name
    zone_id = var.aws_lb_zone_id
    evaluate_target_health = true
  }
}