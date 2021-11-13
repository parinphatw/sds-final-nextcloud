### Gateway ###

# make the public subnet reach the outside world
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.sds-final-vpc.id
  tags = {
    "Name" = "${local.App}_igw"
  }
}

# elastic ip for NAT gateway
resource "aws_eip" "nateIP" {
  vpc = true

  depends_on = [
    aws_internet_gateway.IGW
  ]

  tags = {
    "Name" = "${local.App}_nat_eip"
  }
}

# make the private subnet reach the outside world
resource "aws_nat_gateway" "NGW" {
  allocation_id = aws_eip.nateIP.id
  subnet_id     = aws_subnet.private-subnet.id
  tags = {
    "Name" = "${local.App}_ngw"
  }
}
