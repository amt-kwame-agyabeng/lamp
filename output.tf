output "vpc_id" {
  value       = module.networking.vpc_id
  description = "The ID of the VPC"
}

output "public_subnet_ids" {
  value       = module.networking.public_subnet_ids
  description = "IDs of the public subnets"
}

output "private_subnet_ids" {
  value       = module.networking.private_subnet_ids
  description = "IDs of the private subnets"
}

output "web_security_group_id" {
  value       = module.security.web_sg_id
  description = "ID of the web server security group"
}

output "db_security_group_id" {
  value       = module.security.sql_sg_id
  description = "ID of the database security group"
}


output "sql_security_group_id" {
  value       = module.security.sql_sg_id
  description = "ID of the database security group"

}

output "app_ip" {
  value = module.compute.app_ip
}

output "db_ip" {
  value = module.compute.db_ip
}
