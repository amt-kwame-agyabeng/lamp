# General variables
owner       = "lamp"
environment = "dev"
region      = "eu-west-1"

# Network variables
vpc_name            = "lamp-vpc"
vpc_cidr            = "10.0.0.0/16"
public_subnet_name  = "lamp-public-subnet"
private_subnet_name = "lamp-private-subnet"
igw_name            = "lamp-igw"
nat_eip_name        = "lamp-nat-eip"
nat_gw_name         = "lamp-nat-gw"
public_rt_name      = "lamp-public-rtb"
private_rt_name     = "lamp-private-rtb"

# Security variables
http_port   = 80
https_port  = 443
ssh_port    = 22
mysql_port  = 3306
web_sg_name = "lamp-web-sg"
sql_sg_name = "lamp-sql-sg"
app_sg_name = "lamp-app-sg"


# Compute variables
instance_type = "t2.micro"
ami_id        = ""
key_pair_name = "lamp-key-pair"

# Database connection variables
db_name     = "lamp_test"
db_user     = "lamp_user"
db_password = "password1234567"

