variable "prefix" {
  default = "my-bucket"
}

variable "environment" {
  default = "development"
}

variable "access_role_name" {
  type    = string
  default = null
}

provider "aws" {}

resource "aws_s3_bucket" "b" {
  bucket_prefix = var.prefix
}

resource "aws_iam_role_policy" "full_access_policy" {
  count = var.access_role_name != null ? 1 : 0
  name  = "s3_bucket_access"
  role  = var.access_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.b.arn}"
      },
    ]
  })
}

output "bucket_name" {
  value = aws_s3_bucket.b.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.b.arn
}
