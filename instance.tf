provider "aws" {
  region = var.aws_region
}

# VPC
resource "aws_vpc" "name" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = var.aws_vpc_name
    }
}

# Subnets : Public
resource "aws_subnet" "public" {
    count = length(var.subnets_cidr)
    vpc_id = aws_vpc.name.id
    cidr_block = element(var.subnets_cidr, count.index)
    availability_zone = element(var.azs, count.index)
    tags = {
        Name = "subnet-name- ${count.index+1}"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
        Name = var.aws_igw_name
    }
}

# Route Table: Attach Internet Gateway
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.name.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
  tags = {
    Name = var.aws_rt_name
  }
}

# Rout Table Association with Public Subnets
resource "aws_route_table_association" "name" {
  count = length(var.subnets_cidr)
  subnet_id = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.name.id
}

# AWS Instance
resource "aws_instance" "example_ec2" {
  ami = var.ami-string
  instance_type = var.instance_type
  availability_zone = var.aws_instance_azs
  subnet_id = aws_subnet.public.0.id
  associate_public_ip_address = true
  tags = {
    Name = var.aws_instance_name
  }
}

resource "aws_ebs_volume" "volume1" {
    availability_zone = var.ebs_azs
    size = 10
}

resource "aws_ebs_volume" "volume2" {
    availability_zone = var.ebs_azs
    size = 10
}

resource "aws_volume_attachment" "vname1" {
    device_name = var.volume_device_name1
    volume_id = aws_ebs_volume.volume1.id
    instance_id = aws_instance.example_ec2.id
}

resource "aws_volume_attachment" "vname2" {
    device_name = var.volume_device_name2
    volume_id = aws_ebs_volume.volume2.id
    instance_id = aws_instance.example_ec2.id
}

# # # OUTPUT # # #
output "instance_public_ip" {
    value = aws_instance.example_ec2.public_ip
}

output "instance_state" {
    value = aws_instance.example_ec2.instance_state
    description = "The state of the server instance"
}

output "instance_private_ip_sensitive" {
  value = aws_instance.example_ec2.private_ip
  sensitive = true
}
