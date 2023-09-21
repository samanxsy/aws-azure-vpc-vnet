# Main Terraform Configs
#
# Project: Ephemeral AWS infrastructure for testing
#
# Author: Saman Saybani


module "ec2_instance" {
  source            = "./modules/ec2_instance"

  # Info
  machine_image = "ami-0ec7f9846da6b0f61"
  instance_type = "t2.micro"
  public_ip_required = true

  # Volume
  root_block_volume_size = 50
  encrypt_the_root_block = true

  # Networking
  instance_az = "eu-central-1a"
  subnet_id     = module.vpc.subnet_id
  ec2_security_group = module.vpc.ec2_security_group

  # Connection
  instance_connection_type = "ssh"
  instance_username = "ubuntu"
  ssh_key_name = module.key_pair.ssh_key_name

  # Tags
  instance_tags = {
    Name = "EC2_instance"
    Env = "Test"
  }
}

module "ebs" {
  source = "./modules/ebs"

  ebs_az = "eu-central-1a"
  ebs_size = 20
  encrypt_ebs = true

  ebs_tags = {
    Name = "EBS-VOL"
    Env = "Test"
  }
}

module "vpc" {
  source = "./modules/vpc"
}

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


module "key_pair" {
  source = "./modules/key_par"  
}
