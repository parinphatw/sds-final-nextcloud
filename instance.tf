resource "aws_instance" "app" {
  ami               = var.ami
  availability_zone = var.availability_zone
  instance_type     = var.instance_type
  network_interface {
    network_interface_id = aws_network_interface.app-igw.id
    device_index         = 0
  }
  network_interface {
    network_interface_id = aws_network_interface.app-db.id
    device_index         = 1
  }
  tags = {
    "Name" = "${local.App}_app_instance"
  }
  # volume_tags = {
  #   Name = "${local.App}_block_instance_app"
  # }
}

resource "aws_instance" "db" {
  ami               = var.ami
  availability_zone = var.availability_zone
  instance_type     = var.instance_type
  network_interface {
    network_interface_id = aws_network_interface.db-ngw.id
    device_index         = 0
  }
  network_interface {
    network_interface_id = aws_network_interface.db-app.id
    device_index         = 1
  }
  tags = {
    "Name" = "${local.App}_db_instance"
  }
}
