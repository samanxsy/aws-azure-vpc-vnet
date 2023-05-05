resource "aws_ebs_volume" "volumex1" {
  availability_zone = var.ebs_azs
  size              = 20
  tags = {
    Group = "variablex"
  }
}
