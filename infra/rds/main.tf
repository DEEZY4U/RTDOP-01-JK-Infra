variable "db_subnet_group_name" {}
variable "subnet_groups" {}
variable "rds_mysql_sg_id" {}
variable "mysql_db_identifier" {}
variable "mysql_username" {}
variable "mysql_password" {}
variable "mysql_dbname" {}

output "rds_endpoint" {
  value = aws_db_instance.dev_rtdop_01_rds.address
}

output "rds_db_name" {
  value = aws_db_instance.dev_rtdop_01_rds.db_name
}

resource "aws_db_subnet_group" "dev_rtdop_01_rds_subnet_group" {
  name = var.db_subnet_group_name
  subnet_ids = var.subnet_groups
}

resource "aws_db_instance" "dev_rtdop_01_rds" {
  allocated_storage = 10
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t4g.micro"
  vpc_security_group_ids = [ var.rds_mysql_sg_id ]
  db_subnet_group_name = aws_db_subnet_group.dev_rtdop_01_rds_subnet_group.name
  skip_final_snapshot = true
  apply_immediately = true
  deletion_protection = false
  backup_retention_period = 0

  identifier = var.mysql_db_identifier
  username = var.mysql_username
  password = var.mysql_password
  db_name = var.mysql_dbname
}