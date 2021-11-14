# Create eip for the app-igw network interface
resource "aws_eip" "app-igw_network-interface_eip" {
  vpc               = true
  network_interface = aws_network_interface.app-igw.id
  depends_on = [
    aws_internet_gateway.IGW
  ]
  tags = {
    "Name" = "${local.App}_app-igw_network-interface_eip"
  }
}

resource "aws_network_interface" "app-igw" {
  subnet_id       = aws_subnet.public-subnet.id
  security_groups = [aws_security_group.app-igw.id]
  tags = {
    "Name" = "${local.App}_app-igw_network-interface"
  }
}

resource "aws_network_interface" "app-db" {
  subnet_id       = aws_subnet.db-connection-subnet.id
  security_groups = [aws_security_group.app-db.id]
  tags = {
    "Name" = "${local.App}_app-db_network-interface"
  }
}

resource "aws_network_interface" "db-app" {
  subnet_id       = aws_subnet.db-connection-subnet.id
  security_groups = [aws_security_group.db-app.id]
  tags = {
    "Name" = "${local.App}_db-app_network-interface"
  }
}

resource "aws_network_interface" "db-ngw" {
  subnet_id       = aws_subnet.db-connection-subnet.id
  security_groups = [aws_security_group.db-ngw.id]
  tags = {
    "Name" = "${local.App}_db-ngw_network-interface"
  }
}
