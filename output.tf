output "app_instance_public_ip" {
  value = aws_instance.app.public_ip
}

output "db_instance_private_ip" {
  value = aws_instance.db.private_ip
}
