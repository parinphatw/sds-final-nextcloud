resource "aws_security_group" "app-igw" {
  name   = "app-igw_sec-group"
  vpc_id = aws_vpc.sds-final-vpc.id

  tags = {
    Name = "${local.App}_app-igw_sec-group"
  }
}

##########################  APP - IGW  ###################################
resource "aws_security_group_rule" "public_http_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app-igw.id
}

resource "aws_security_group_rule" "public_https_rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app-igw.id
}

resource "aws_security_group_rule" "public_ssh_rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app-igw.id
}

resource "aws_security_group_rule" "public_all_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app-igw.id
}
#############################################################

resource "aws_security_group" "app-db" {
  name   = "app-db_sec-group"
  vpc_id = aws_vpc.sds-final-vpc.id


  tags = {
    Name = "${local.App}_app-db_sec-group"
  }
}

################## app - db ##############################
resource "aws_security_group_rule" "app-db_egress_rule" {
  type              = "egress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [var.app2db_subnet]
  security_group_id = aws_security_group.app-db.id
}
##########################################################

resource "aws_security_group" "db-app" {
  name   = "db-app_sec-group"
  vpc_id = aws_vpc.sds-final-vpc.id


  tags = {
    Name = "${local.App}_db-app_sec-group"
  }
}

####################### db - app ####################
resource "aws_security_group_rule" "private_db_rule" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [var.app2db_subnet]
  security_group_id = aws_security_group.db-app.id
}
#####################################################

resource "aws_security_group" "db-ngw" {
  name   = "db-ngw_sec-group"
  vpc_id = aws_vpc.sds-final-vpc.id


  tags = {
    Name = "${local.App}_db-ngw_sec-group"
  }
}

###################### db - ngw ##############
resource "aws_security_group_rule" "private_database_all_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db-ngw.id
}
##############################################
