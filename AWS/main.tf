terraform {
  backend "s3" {
    bucket = "statebucketx"
    key    = "states/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

module "ec2-instance" {
  source            = "./modules/ec2-instance"
  aws_subnet_id     = module.vpc.subnet_id
  aws_instance_name = var.aws_instance_name
}

module "ebs" {
  source = "./modules/ebs"
}

module "vpc" {
  source = "./modules/vpc"
}

resource "aws_volume_attachment" "volume_attachment1" {
  device_name = var.volume_device_name
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
