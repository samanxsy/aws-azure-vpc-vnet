# Main Terraform Configs
#
# Project: Ephemeral AWS infrastructure
#
# Author: Saman Saybani

module "ec2_instance" {
  source = "./modules/ec2_instance"

  # Info
  machine_image      = "ami-0ec7f9846da6b0f61"
  instance_type      = "t2.micro"
  public_ip_required = true

  # Volume
  root_block_volume_size = 50
  encrypt_the_root_block = true

  # Networking
  instance_az        = "eu-central-1a"
  subnet_id          = data.aws_subnet.frankfurt_public_subnet_1.id
  ec2_security_group = [data.aws_security_group.default_sg.id]

  # Connection
  instance_connection_type = "ssh"
  instance_username        = "ubuntu"
  ssh_key_name             = module.key_pair.ssh_key_name

  # Tags
  instance_tags = {
    Name = "EC2_instance"
    Env  = "Test"
  }
}

# EBS
module "ebs" {
  source = "./modules/ebs"

  ebs_az      = "eu-central-1a"
  ebs_size    = 20
  encrypt_ebs = true

  ebs_tags = {
    Name = "EBS-VOL"
    Env  = "Test"
  }
}

# Vol Attach
resource "aws_volume_attachment" "volume_attachment1" {
  device_name = "/dev/sda"
  volume_id   = module.ebs.ebs_volume_id
  instance_id = module.ec2_instance.instance_id

  lifecycle {
    ignore_changes = [
      device_name,
      volume_id,
      instance_id
    ]
  }
}

# Key Pair
module "key_pair" {
  source = "./modules/key_pair"
}

# Subnet Data
data "aws_subnet" "frankfurt_public_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["frankfurt-public-subnet-1"]
  }
}

# Security Group Data
data "aws_security_group" "default_sg" {
  filter {
    name   = "tag:Name"
    values = ["def-sgx"]
  }
}
