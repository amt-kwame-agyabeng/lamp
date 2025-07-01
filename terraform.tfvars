# General variables
owner       = "lampstack"
environment = "dev"
region      = "eu-central-1"

# Network variables
vpc_name            = "lampstack-vpc"
vpc_cidr            = "10.0.0.0/20"
public_subnet_name  = "lampstack-public-subnet"
private_subnet_name = "lampstack-private-subnet"
igw_name            = "lampstack-igw"
nat_eip_name        = "lampstack-nat-eip"
nat_gw_name         = "lampstack-nat-gw"
public_rt_name      = "lampstack-public-rtb"
private_rt_name     = "lampstack-private-rtb"

# Security variables
http_port   = 80
https_port  = 443
ssh_port    = 22
mysql_port  = 3306
web_sg_name = "lampstack-web-sg"
sql_sg_name = "lampstack-sql-sg"
app_sg_name = "lampstack-app-sg"


# Compute variables
instance_type = "t2.micro"
ami_id        = "ami-0229b8f55e5178b65"
key_pair_name = "frankfurt"

# Database connection variables
db_name     = "lampdb"
db_user     = "lampuser"
db_password = "password1234567"

