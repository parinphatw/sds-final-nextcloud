resource "aws_iam_user" "s3" {
  name = "${local.App}_s3_iam_user"
  path = "/storage/"

  tags = {
    Name = "${local.App}_iam_user_s3"
  }
}

resource "aws_iam_policy" "s3" {
  name   = "nextcloud-s3-all-access-control"
  policy = data.aws_iam_policy_document.policy.json
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions   = ["s3:*"]
    resources = [aws_s3_bucket.bucket.arn, "${aws_s3_bucket.bucket.arn}/*"]
    effect    = "Allow"
  }
  statement {
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey",
      "kms:GenerateDataKeyWithoutPlaintext",
      "kms:GenerateDataKeyPairWithoutPlaintext",
      "kms:GenerateDataKeyPair"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_user_policy_attachment" "s3" {
  user       = aws_iam_user.s3.name
  policy_arn = aws_iam_policy.s3.arn
}

resource "aws_iam_access_key" "s3" {
  user = aws_iam_user.s3.name
}
