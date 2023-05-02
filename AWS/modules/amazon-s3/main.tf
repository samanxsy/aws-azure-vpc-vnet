resource "aws_s3_bucket" "bucketx" {
    bucket = var.bucket_name
    acl = "private"

    versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = false
    }

    tags = {
        Name = var.bucket_name
    }
}
