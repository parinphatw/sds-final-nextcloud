resource "aws_vpc" "sds-final-vpc" {
  cidr_block       = var.main_vpc_cidr
  instance_tenancy = "default"
  tags = {
    "Name" = "${local.App}_vpc"
  }
}
