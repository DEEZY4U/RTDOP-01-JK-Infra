variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "cidr_private_subnet" {}
variable "us-east-az" {}

output "dev_rtdop_01_vpc_id" {
  value = aws_vpc.dev_rtdop_01_vpc_us_east_1.id
}

output "dev_rtdop_01_public_subnets" {
  value = aws_subnet.dev_rtdop_01_public_subnets.*.id
}

output "dev_rtdop_01_private_subnets" {
  value = aws_subnet.dev_rtdop_01_private_subnets.*.id
}

output "dev_rtdop_01_public_subnets_cidr_block" {
  value = aws_subnet.dev_rtdop_01_public_subnets.*.cidr_block
}

# Setup VPC
resource "aws_vpc" "dev_rtdop_01_vpc_us_east_1" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# setup public subnet
resource "aws_subnet" "dev_rtdop_01_public_subnets" {
  count = length(var.cidr_public_subnet)
  vpc_id = aws_vpc.dev_rtdop_01_vpc_us_east_1.id
  cidr_block = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.us-east-az, count.index)

  tags = {
    Name = "dev-rtdop-01-public-subnet-${count.index + 1}"
  }
}

# setup private subnet
resource "aws_subnet" "dev_rtdop_01_private_subnets" {
  count = length(var.cidr_private_subnet)
  vpc_id = aws_vpc.dev_rtdop_01_vpc_us_east_1.id
  cidr_block = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.us-east-az, count.index)

  tags = {
    Name = "dev-rtdop-01-private-subnet-${count.index + 1}"
  }
}

# set internet gateway
resource "aws_internet_gateway" "dev_rtdop_01_public_igw" {
  vpc_id = aws_vpc.dev_rtdop_01_vpc_us_east_1.id

  tags = {
    Name = "dev-rtdop-01-igw"
  }
}

# set public route table
resource "aws_route_table" "dev_rtdop_01_public_rt" {
  vpc_id = aws_vpc.dev_rtdop_01_vpc_us_east_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_rtdop_01_public_igw.id
  }

  tags = {
    Name = "dev-rtdop-01-public-rt"
  }
}

# set private route table
resource "aws_route_table" "dev_rtdop_01_private_rt" {
  vpc_id = aws_vpc.dev_rtdop_01_vpc_us_east_1.id

  tags = {
    Name = "dev-rtdop-01-private-rt"
  }
}

# public rt & public subnet association
resource "aws_route_table_association" "dev_rtdop_01_public_rt_subnet_association" {
  count = length(aws_subnet.dev_rtdop_01_public_subnets)
  subnet_id = aws_subnet.dev_rtdop_01_public_subnets[count.index].id
  route_table_id = aws_route_table.dev_rtdop_01_public_rt.id
}

# private rt & private subnet association
resource "aws_route_table_association" "dev_rtdop_01_private_rt_subnet_association" {
  count = length(aws_subnet.dev_rtdop_01_private_subnets)
  subnet_id = aws_subnet.dev_rtdop_01_private_subnets[count.index].id
  route_table_id = aws_route_table.dev_rtdop_01_private_rt.id
}