variable "region" {
  description = "Region in AWS for the Nextcloud app"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone in AWS for the Nextcloud app"
  type        = string
}

variable "ami" {
  description = "AMI in AWS for the Nextcloud app"
  type        = string
}

variable "bucket_name" {
  description = "Bucket name in AWS for the Nextcloud app"
  type        = string
}

variable "database_name" {
  description = "Database name in AWS for the Nextcloud app"
  type        = string
}

variable "database_user" {
  description = "Database user in AWS for the Nextcloud app"
  type        = string
}

variable "database_pass" {
  description = "Database password in AWS for the Nextcloud app"
  type        = string
}

variable "admin_user" {
  description = "Database Admin user in AWS for the Nextcloud app"
  type        = string
}

variable "admin_pass" {
  description = "Database Admin password in AWS for the Nextcloud app"
  type        = string
}
