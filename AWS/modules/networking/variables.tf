# Networking
#
# Variables


# VPC
variable "vpc_cidr" {
  description = "CIDR range for the VPC"
  type        = string
  default     = "10.20.0.0/16"
}

variable "vpc_tags" {
  description = "VPC tags"
  type = object({
    Name = string
    Env  = string
  })
}

# Subnet
variable "subnet_cidr" {
  description = "subnet ranges"
  type        = list(string)
  default     = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "azs" {
  description = "Availability Zone"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "subnet_tags" {
  type = object({
    Name = string # "Subnetx-${count.index + 1}"
    Env  = string
  })
}


# Security Groups
variable "security_group_name" {
  type    = string
  default = "default_sg"
}

variable "security_group_description" {
  type    = string
  default = "Managing Ingress and Egress traffic"
}

variable "security_group_tags" {
  type = object({
    Name = string
    Env  = string
  })
}


variable "ingress_rules" {
  description = "ingress rules"
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = {
    rule1 = {
      description = "ALLOWING HTTP From self IP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["89.134.14.13/32"]
    },
    rule2 = {
      description = "ALLOWING HTTP From self IP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["89.134.14.13/32"]
    },
    // Add more as necessary
  }
}


variable "egress_rules" {
  description = "egress rules"
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = {
    rule1 = {
      description = "ALLOWING ALL OUTBOUND"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
    // Add more as necessary
  }
}

# Traffic routing
variable "internet_gw_tags" {
  type = object({
    Name = string
    Env  = string
  })
}

variable "route_table_tags" {
  type = object({
    Name = string
    Env  = string
  })
}

variable "acl_ingress_rules" {
  type = map(object({
    protocol   = string
    rule_no    = number
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "acl_egress_rules" {
  type = map(object({
    protocol   = string
    rule_no    = number
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}





