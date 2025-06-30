
output "web_sg_id" {
  description = "ID of the web server security group"
  value       = aws_security_group.web_sg.id
}

output "sql_sg_id" {
  description = "ID of the database server security group"
  value       = aws_security_group.sql_sg.id
}

output "app_sg_id" {
  description = "ID of the application server security group"
  value       = aws_security_group.app_sg.id
  
}