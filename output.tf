output "app_instance_public_ip" {
  value = aws_instance.app.public_ip
}

output "db_instance_private_ip" {
  value = aws_instance.db.private_ip
}

output "app-igw_ni_private_ip" {
  value = aws_network_interface.app-igw.private_ip
}

output "app-db_ni_private_ip" {
  value = aws_network_interface.app-db.private_ip
}

output "db-app_ni_private_ip" {
  value = aws_network_interface.db-app.private_ip
}

output "db-ngw_ni_private_ip" {
  value = aws_network_interface.db-ngw.private_ip
}
