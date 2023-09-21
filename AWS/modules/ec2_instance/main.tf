################################################################
######################## EC2 INSTANCE ##########################
################################################################

# AWS EC2 INSTANCE
#
# Main terraform config


resource "aws_instance" "ec2_instance" {
  ami                         = var.machine_image
  instance_type               = var.instance_type
  
  associate_public_ip_address = var.public_ip_required

  availability_zone           = var.instance_az
  subnet_id                   = var.subnet_id
  security_groups = var.ec2_security_group


  root_block_device {
    volume_size = var.root_block_volume_size
    encrypted = var.encrypt_the_root_block
  }

  key_name                    =  var.ssh_key_name

  connection {
    type = var.instance_connection_type
    user = var.instance_username
    private_key = file("ec2key")
    host = aws_instance.ec2_instance.public_ip
  }

  tags = var.instance_tags
}
