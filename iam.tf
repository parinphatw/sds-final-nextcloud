# EC2 IAM
## profile
### app
resource "aws_iam_instance_profile" "app" {
  name = "${local.App}_app_instance_profile"
  role = aws_iam_role.app.name

  tags = {
    "Name" = "${local.App}_app_instance_profile"
  }
}
### db
resource "aws_iam_instance_profile" "db" {
  name = "${local.App}_db_instance_profile"
  role = aws_iam_role.db.name

  tags = {
    Name = "${local.App}_db_instance_profile"
  }
}
## policy documentation datasource
data "aws_iam_policy_document" "ec2" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
## Role
### app
resource "aws_iam_role" "app" {
  name               = "${local.App}_app_iam_role"
  path               = "/${local.App}/"
  assume_role_policy = data.aws_iam_policy_document.ec2.json

  tags = {
    Name = "${local.App}_app_iam_role"
  }
}
### db
resource "aws_iam_role" "db" {
  name               = "${local.App}_db_iam_role"
  path               = "/${local.App}/"
  assume_role_policy = data.aws_iam_policy_document.ec2.json

  tags = {
    Name = "${local.App}_db_iam_role"
  }
}
## core system manager
### policy
data "aws_iam_policy" "sys-mng" {
  name = "AmazonSSMManagedInstanceCore"
}
### app policy attachment
resource "aws_iam_role_policy_attachment" "app_mng" {
  role       = aws_iam_role.app.name
  policy_arn = data.aws_iam_policy.sys-mng.arn
}
### db policy attachment
resource "aws_iam_role_policy_attachment" "db_mng" {
  role       = aws_iam_role.db.name
  policy_arn = data.aws_iam_policy.sys-mng.arn
}
# S3
