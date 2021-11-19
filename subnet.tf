### Subnets ###
resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.sds-final-vpc.id
  availability_zone = var.availability_zone
  cidr_block        = var.public_subnet
  tags = {
    "Name" = "${local.App}_public_subnet"
  }
  depends_on = [
    aws_internet_gateway.IGW
  ]
}

resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.sds-final-vpc.id
  availability_zone = var.availability_zone
  cidr_block        = var.private_subnet
  tags = {
    "Name" = "${local.App}_private_subnet"
  }
}

resource "aws_subnet" "db-connection-subnet" {
  vpc_id            = aws_vpc.sds-final-vpc.id
  availability_zone = var.availability_zone
  cidr_block        = var.app2db_subnet
  tags = {
    "Name" = "${local.App}_db-connection_subnet"
  }
}
