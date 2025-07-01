resource "aws_ssm_parameter" "app_ip" {
  name  = "/feedback/app_ip"
  type  = "String"
  value = aws_instance.app.private_ip
}

resource "aws_ssm_parameter" "db_ip" {
  name  = "/feedback/db_ip"
  type  = "String"
  value = aws_instance.db.private_ip
}
