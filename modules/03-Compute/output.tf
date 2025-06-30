output "web_instance_ip" {
  value = aws_instance.web.public_ip
}

output "app_instance_ip" {
  value = aws_instance.app.private_ip
}

output "db_instance_ip" {
  value = aws_instance.db.private_ip
}
