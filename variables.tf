variable "owner" {
  description = "Owner of the resources"
  type        = string

}

variable "environment" {
  description = "The environment of the project"
  type        = string

}

variable "region" {
  description = "The region of your VPC"
  type        = string

}


#---------------------
#Variables for Network modules
#---------------------


variable "vpc_name" {
  description = "The name of your VPC"
  type        = string

}

variable "vpc_cidr" {
  description = "The cidr block of your VPC"
  type        = string

}

# This variable is no longer needed as we're using the VPC ID from the networking module

variable "public_subnet_name" {
  description = "The name of the publlic subnet"
  type        = string

}
variable "private_subnet_name" {
  description = "The name of the private subnet"
  type        = string

}

variable "igw_name" {
  description = "The name of the internet gateway"
  type        = string

}

variable "nat_eip_name" {
  description = "The name of the elastic ip"
  type        = string

}

variable "nat_gw_name" {
  description = "The name of the NAT gateway"
  type        = string

}

variable "public_rt_name" {
  description = "The name of public route table"
  type        = string

}

variable "private_rt_name" {
  description = "The name of the private route table"
  type        = string
}


#---------------------
#Variables for Security modules
#---------------------

variable "http_port" {
  description = "The port to use for HTTP"
  type        = number

}
variable "https_port" {
  description = "The port to use for HTTPS"
  type        = number

}

variable "mysql_port" {
  description = "The port to use for MySQL"
  type        = number


}
variable "ssh_port" {
  description = "The port to use for SSH"
  type        = number


}

variable "web_sg_name" {
  description = "The name of the Webserver security group"
  type        = string


}

variable "sql_sg_name" {
  description = "The name of the MySQL security group"
  type        = string


}

variable "app_sg_name" {
  description = "The name of the Application security group"
  type        = string


}



#---------------------
#Variables for Compute modules
#---------------------

variable "instance_type" {
  description = "The instance type of the instances"
  type        = string

}

variable "ami_id" {
  description = "The AMI ID"
  type        = string

}

variable "key_pair_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string

}

#---------------------
#Variables for Database Connection
#---------------------

# variable "db_host" {
#   description = "Database host address"
#   type        = string
# }

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_user" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "sg_sql_id" {
  description = "Security group ID for SQL"
  type        = string

}