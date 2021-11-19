data "template_file" "nextcloud_setup" {
  template = file("nextcloud_setup.sh")
  vars = {
    database_name = var.database_name
    database_user = var.database_user
    database_pass = var.database_pass
    admin_user    = var.admin_user
    admin_pass    = var.admin_pass
    REGION        = var.region
    PUBLIC_IP     = aws_eip.app-igw_network-interface_eip.public_ip
    DB_PRIVATE_IP = aws_network_interface.db-app.private_ip
    BUCKET_NAME   = aws_s3_bucket.bucket.bucket
    ACCESS_ID     = aws_iam_access_key.s3.id
    ACCESS_SECRET = aws_iam_access_key.s3.secret
    BUCKET_DOMAIN = aws_s3_bucket.bucket.bucket_domain_name
  }
}

data "template_file" "database_setup" {
  template = file("db_setup.sh")
  vars = {
    database_name       = var.database_name
    database_user       = var.database_user
    database_pass       = var.database_pass
    INSTANCE_PRIVATE_IP = aws_network_interface.app-db.private_ip
  }
}

resource "aws_instance" "app" {
  ami = var.ami
  # availability_zone = var.availability_zone
  instance_type = var.instance_type
  network_interface {
    network_interface_id = aws_network_interface.app-igw.id
    device_index         = 0
  }
  network_interface {
    network_interface_id = aws_network_interface.app-db.id
    device_index         = 1
  }

  user_data = data.template_file.nextcloud_setup.rendered

  tags = {
    "Name" = "${local.App}_app_instance"
  }

  depends_on = [
    aws_s3_bucket.bucket,
    aws_instance.db
  ]
}

resource "aws_instance" "db" {
  ami = var.ami
  # availability_zone = var.availability_zone
  instance_type = var.instance_type
  network_interface {
    network_interface_id = aws_network_interface.db-ngw.id
    device_index         = 0
  }
  network_interface {
    network_interface_id = aws_network_interface.db-app.id
    device_index         = 1
  }

  user_data = data.template_file.database_setup.rendered

  tags = {
    "Name" = "${local.App}_db_instance"
  }
}

