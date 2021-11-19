### Gateway ###

# make the public subnet reach the outside world
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.sds-final-vpc.id
  tags = {
    "Name" = "${local.App}_igw"
  }
}

# make the private subnet reach the outside world
resource "aws_nat_gateway" "NGW" {
  allocation_id = aws_eip.NGW.id
  subnet_id     = aws_subnet.public-subnet.id
  tags = {
    "Name" = "${local.App}_ngw"
  }
}

resource "aws_eip" "NGW" {
  vpc = true

  tags = {
    "Name" = "${local.App}_nat_eip"
  }
}
