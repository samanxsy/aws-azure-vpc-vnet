resource "aws_ebs_volume" "volumex1" {
  availability_zone = var.ebs_azs
  size              = 20
  encrypted = true

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Group = "variablex"
  }
}
