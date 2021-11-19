resource "aws_vpc" "sds-final-vpc" {
  cidr_block = var.main_vpc_cidr
  tags = {
    "Name" = "${local.App}_vpc"
  }
}
