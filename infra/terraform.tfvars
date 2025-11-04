vpc_cidr = "11.0.0.0/16"
vpc_name = "dev-rtdop-01-us-east-1-vpc"
cidr_public_subnet = ["11.0.1.0/24", "11.0.3.0/24"]
cidr_private_subnet = ["11.0.2.0/24", "11.0.4.0/24"]
us_east_az = ["us-east-1a", "us-east-1b"]

key_name = "Infra_AWS"
public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMi+zvjrAljb8aFIyO4mrpebse65SR72NSpvmrOgicUY deezy@elaine"
ami_id = "ami-0ecb62995f68bb549"

domain_name = "todo.deezyboi.space"