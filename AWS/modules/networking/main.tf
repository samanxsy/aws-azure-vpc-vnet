# Networking
#
# Main Terraform Config


# VPC
resource "aws_vpc" "vpcx" {
  cidr_block = var.vpc_cidr
  tags       = var.vpc_tags
}

# Subnet
resource "aws_subnet" "public" {
  count = length(var.subnet_cidr)

  vpc_id            = aws_vpc.vpcx.id
  cidr_block        = element(var.subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = var.subnet_tags
}

# Security Group and Rules
resource "aws_security_group" "ec2_sg" {
  name        = var.security_group_name
  description = var.security_group_description

  vpc_id = aws_vpc.vpcx.id
  tags   = var.security_group_tags

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules

    content {
      description = egress.value["description"]
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }
}


# Internet GateWay
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpcx.id
  tags   = var.internet_gw_tags
}

# RoutTable : Attach Internet GateWay
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpcx.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }

  tags = var.route_table_tags
}

# Route Table association with the Public Subnets
resource "aws_route_table_association" "association" {
  count          = length(var.subnet_cidr)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.route_table.id
}

# Network ACL
resource "aws_network_acl" "acl" {
  vpc_id = aws_vpc.vpcx.id

  dynamic "ingress" {
    for_each = var.acl_ingress_rules

    content {
      protocol   = ingress.value["protocol"]
      rule_no    = ingress.value["rule_no"]
      action     = ingress.value["action"]
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["from_port"]
      to_port    = ingress.value["to_port"]
    }
  }

  dynamic "egress" {
    for_each = var.acl_egress_rules

    content {
      protocol   = egress.value["protocol"]
      rule_no    = egress.value["rule_no"]
      action     = egress.value["action"]
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["from_port"]
      to_port    = egress.value["to_port"]
    }
  }
}
