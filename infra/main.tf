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

module "ec2" {
  source = "./ec2"
  ami_id = var.ami_id
  instance_type = "t2.micro"
  key_name = var.key_name
  public_key = var.public_key
  tag_name = "EC2 Ubuntu"
  subnet_id = tolist(module.networking.dev_rtdop_01_public_subnets)[0]
  sg_enable_ssh_http = module.security_groups.sg_ec2_sg_ssh_https_id
  sg_enable_app_port = module.security_groups.sg_ec2_python_app_id
  enable_public_id = true
  user_data_install_apache = templatefile("./template/ec2_install_app.sh", {
    db_endpoint = module.rds_db_instance.rds_endpoint
  })
}

module "rds_db_instance" {
  source = "./rds"
  db_subnet_group_name = "dev_rtdop_01_rds_subnet_group"
  subnet_groups = tolist(module.networking.dev_rtdop_01_private_subnets)
  rds_mysql_sg_id = module.security_groups.sg_ec2_sg_rds_id
  mysql_db_identifier = "mydb"
  mysql_username = "dbuser"
  mysql_password = "dbpassword"
  mysql_dbname = "devprojdb"
}

module "lb_target_group" {
  source = "./lb-target-group"
  lb_target_group_name = "dev-rtdop-01-lb-target-group"
  lb_target_group_port = 5000
  lb_target_group_protocol = "HTTP"
  vpc_id = module.networking.dev_rtdop_01_vpc_id
  ec2_instance_id = module.ec2.dev_rtdop_01_ec2_instance_id
}