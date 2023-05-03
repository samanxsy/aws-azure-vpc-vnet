resource "aws_instance" "instancex" {
  ami                         = var.machine_image
  instance_type               = var.instance_type
  availability_zone           = var.aws_instance_azs
  subnet_id                   = var.aws_subnet_id
  associate_public_ip_address = true
  key_name                    = "ec2key"
  tags = {
    Name  = var.aws_instance_name
    Group = "variablex"
  }
}
