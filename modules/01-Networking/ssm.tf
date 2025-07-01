resource "aws_ssm_parameter" "vpc_id" {
  name        = "/lamp-stack/${var.environment}/vpc/id"
  description = "VPC ID"
  type        = "String"
  value       = aws_vpc.vpc.id
  overwrite = true
  
  tags = local.common_tags
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name        = "/lamp-stack/${var.environment}/subnet/public/ids"
  description = "Public Subnet IDs"
  type        = "String"
  value       = join(",", aws_subnet.public_subnet[*].id)
  overwrite = true
  
  tags = local.common_tags
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name        = "/lamp-stack/${var.environment}/subnet/private/ids"
  description = "Private Subnet IDs"
  type        = "String"
  value       = join(",", aws_subnet.private_subnet[*].id)
  overwrite = true
  
  tags = local.common_tags
}