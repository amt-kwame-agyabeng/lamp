
# Store database connection information in SSM Parameter Store
resource "aws_ssm_parameter" "db_host" {
  name  = "/${var.environment}/database/host"
  type  = "String"
  value = aws_db_instance.rds_mysql.endpoint
  tags  = local.common_tags
}

resource "aws_ssm_parameter" "db_name" {
  name  = "/${var.environment}/database/name"
  type  = "String"
  value = var.db_name
  tags  = local.common_tags
}

resource "aws_ssm_parameter" "db_user" {
  name  = "/${var.environment}/database/user"
  type  = "String"
  value = var.db_username
  tags  = local.common_tags
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/${var.environment}/database/password"
  type  = "SecureString"
  value = var.db_password
  tags  = local.common_tags
}