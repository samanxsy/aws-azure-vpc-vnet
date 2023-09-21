# EBS Volume
#
# Main Terraform Config


resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = var.ebs_az
  size              = var.ebs_size
  encrypted = var.encrypt_ebs

  lifecycle {
    prevent_destroy = false
  }

  tags = var.ebs_tags
}
