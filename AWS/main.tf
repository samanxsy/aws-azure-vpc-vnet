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
  subnet_id          = module.networking.subnet_id
  ec2_security_group = module.networking.ec2_security_group

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

module "networking" {
  source = "./modules/networking"

  # VPC
  vpc_cidr = "10.20.0.0/16"
  vpc_tags = {
    Name = "vpc"
    Env  = "Test"
  }

  # Subnets
  subnet_cidr = ["10.20.1.0/24", "10.20.2.0/24"]
  azs         = ["eu-central-1a", "eu-central-1b"]
  subnet_tags = {
    Name = "Subnets"
    Env  = "Test"
  }

  # Security Groups
  security_group_name        = "security_groupx"
  security_group_description = "Managing Ingress and Egress traffic"

  # Ingress Rules
  ingress_rules = {
    rule1 = {
      description = "ALLOWING HTTP From self IP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [local.my_public_ip]
    },
    rule2 = {
      description = "ALLOWING SSH From self IP"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [local.my_public_ip]
    }
  }

  # Egress rules
  egress_rules = {
    rule1 = {
      description = "ALLOWING ALL OUTBOUND"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  security_group_tags = {
    Name = "Security Group"
    Env  = "Test"
  }

  # Traffic Routing
  internet_gw_tags = {
    Name = "internet gateway"
    Env  = "Test"
  }

  route_table_tags = {
    Name = "Route Table"
    Env  = "Test"
  }

  acl_ingress_rules = {
    rule1 = {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = local.my_public_ip
      from_port  = 22
      to_port    = 22
    },
    rule2 = {
      protocol   = "tcp"
      rule_no    = 101
      action     = "allow"
      cidr_block = local.my_public_ip
      from_port  = 80
      to_port    = 80
    }
  }

  acl_egress_rules = {
    rule1 = {
      protocol   = "-1"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  }
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
  source = "./modules/key_pair"
}


# Getting the self Public IP 
data "external" "my_ip" {
  program = ["bash", "./modules/networking/get_ip.sh"]
}

locals {
  my_public_ip = data.external.my_ip.result.my_public_ip
}
