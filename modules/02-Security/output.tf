
output "web_sg_id" {
  value = aws_security_group.web_sg.id
}

output "app_sg_id" {
  value = aws_security_group.app_sg.id
}

output "sql_sg_id" {
  value = aws_security_group.sql_sg.id
}
