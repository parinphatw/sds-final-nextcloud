resource "aws_security_group" "app-igw" {
  name   = "app-igw_sec-group"
  vpc_id = aws_vpc.sds-final-vpc.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Allow all egress traffics"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${local.App}_app-igw_sec-group"
  }
}

resource "aws_security_group" "app-db" {
  name   = "app-db_sec-group"
  vpc_id = aws_vpc.sds-final-vpc.id

  egress {
    description = "Traffic from app to db"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.app2db_subnet]
  }

  tags = {
    Name = "${local.App}_app-db_sec-group"
  }
}

resource "aws_security_group" "db-app" {
  name   = "db-app_sec-group"
  vpc_id = aws_vpc.sds-final-vpc.id

  ingress {
    description = "DB receiving traffic from app"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.app2db_subnet]
  }

  tags = {
    Name = "${local.App}_db-app_sec-group"
  }
}

resource "aws_security_group" "db-ngw" {
  name   = "db-ngw_sec-group"
  vpc_id = aws_vpc.sds-final-vpc.id

  egress {
    description      = "Allow all egress traffics"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${local.App}_db-ngw_sec-group"
  }
}
