terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.64.2"
    }
  }
}

locals {
  App = "sds-nextcloud"
}

#output "admin_pass" {
#  value = var.admin_pass
#}
