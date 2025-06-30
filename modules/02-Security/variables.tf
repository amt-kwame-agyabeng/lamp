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


variable "vpc_id" {
    description = "The id of the VPC"
    type = string
    
  
}

variable "http_port" {
    description = "The port to use for HTTP"
    type = number
  
}
variable "https_port" {
    description = "The port to use for HTTPS"
    type = number
  
}

variable "mysql_port" {
    description = "The port to use for MySQL"
    type = number

  
}
variable "ssh_port" {
    description = "The port to use for SSH"
    type = number
    
  
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
    description = "The name of the App security group"
    type        = string
  
}
