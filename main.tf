terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.64.2"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

#output "admin_pass" {
#  value = var.admin_pass
#}
