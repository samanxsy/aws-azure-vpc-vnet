resource "aws_key_pair" "ssh_pair" {
  key_name = "ec2key"
  public_key = file("modules/ec2-instance/ec2key.pub")
}

resource "aws_instance" "instancex1" {
  ami                         = var.machine_image
  instance_type               = var.instance_type
  availability_zone           = var.aws_instance_azs
  subnet_id                   = var.aws_subnet_id
  associate_public_ip_address = true

  key_name                    = aws_key_pair.ssh_pair.key_name

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("modules/ec2-instances/ec2key")
    host = self.public_ip
  }

  tags = {
    Name  = "instancex"
    Group = "variablex"
  }
}
