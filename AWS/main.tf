provider "aws" {
    region = var.aws_region
}

module "ec2-instance" {
    source = "./modules/ec2-instance"
    aws_subnet_id = module.vpc.subnet.id
}

module "ebs" {
    source = "./modules/ebs"
}

module "vpc" {
  source = "./modules/vpc"
}

resource "aws_volume_attachment" "volumex" {
    device_name = var.volume_device_volumex
    volume_id = module.ebs.ebs_volume_name
    instance_id = module.ec2-instance.instance_id
}
