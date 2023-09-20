# Main Terraform Configs
#
# Project: Ephemeral AWS infrastructure for testing
#
# Author: Saman Saybani


module "ec2-instance" {
  source            = "./modules/ec2-instance"
  aws_subnet_id     = module.vpc.subnet_id
  aws_instance_name = var.aws_instance_name
  ec2_security_group = module.vpc.ec2_security_group
}

module "ebs" {
  source = "./modules/ebs"
}

module "vpc" {
  source = "./modules/vpc"
}

resource "aws_volume_attachment" "volume_attachment1" {
  device_name = "/dev/sda"
  volume_id   = module.ebs.ebs_volume_id_1
  instance_id = module.ec2-instance.instance1_id

  lifecycle {
    ignore_changes = [ 
      device_name,
      volume_id,
      instance_id
     ]
  }
}
