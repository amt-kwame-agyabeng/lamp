resource "aws_ssm_parameter" "sg_web_id" {
  name        = "/lamp-stack/${var.environment}/sg/web/id"
  description = "Web Server Security Group ID"
  type        = "String"
  value       = aws_security_group.web_sg.id

  overwrite = true
  
  tags = local.common_tags
}

resource "aws_ssm_parameter" "sg_sql_id" {
  name        = "/lamp-stack/${var.environment}/sg/db/id"
  description = "Database Security Group ID"
  type        = "String"
  value       = aws_security_group.sql_sg.id

  overwrite = true
  
  tags = local.common_tags
}

resource "aws_ssm_parameter" "sg_app_id" {
  name        = "/lamp-stack/${var.environment}/sg/app/id"
  description = "Application Server Security Group ID"
  type        = "String"
  value       = aws_security_group.app_sg.id

  overwrite = true
  
  tags = local.common_tags
  
}

