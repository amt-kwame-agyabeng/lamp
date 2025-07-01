output "app_ip" {
  value = aws_instance.app.private_ip
}

output "db_ip" {
  value = aws_instance.db.private_ip
}
