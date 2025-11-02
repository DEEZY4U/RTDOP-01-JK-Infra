module "networking" {
  source = "./networking"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  cidr_public_subnet = var.cidr_public_subnet
  cidr_private_subnet = var.cidr_private_subnet
  us-east-az = var.us_east_az
}

module "security_groups" {
  source = "./security-groups"
  vpc_id = module.networking.dev_rtdop_01_vpc_id
  public_subnet_cidr_block = tolist(module.networking.dev_rtdop_01_public_subnets_cidr_block)
  ec2_sg_name = "SG for SSH, HTTP & HTTPS"
  ec2_sg_python_app = "SG for Python App Port"
  ec2_sg_rds_name = "SG for RDS"
}