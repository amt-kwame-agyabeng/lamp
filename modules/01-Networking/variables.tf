variable "owner" {
    description = "Owner of the resources"
    type = string
  
}

variable "environment" {
    description = "The environment of the project"
    type = string
  
}

variable "region" {
    description = "The region of your VPC"
    type = string
  
}


variable "vpc_name" {
    description = "The name of your VPC"
    type = string
  
}

variable "vpc_cidr" {
    description = "The cidr block of your VPC"
    type = string
  
}

variable "public_subnet_name" {
    description = "The name of the publlic subnet"
    type = string

}
variable "private_subnet_name" {
    description = "The name of the private subnet"
    type = string
  
}

variable "igw_name" {
    description = "The name of the internet gateway"
    type = string
  
}

variable "nat_eip_name" {
    description = "The name of the elastic ip"
    type = string
  
}

variable "nat_gw_name" {
    description = "The name of the NAT gateway"
    type = string
  
}

variable "public_rt_name" {
    description = "The name of public route table"
    type = string
  
}

variable "private_rt_name" {
    description = "The name of the private route table"
    type = string
}
  
