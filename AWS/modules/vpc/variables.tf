variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "aws_vpc_name" {
  type    = string
  default = "vpcx"
}

variable "subnet_cidr" {
  type    = list(string)
  default = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["eu-central-1a", "eu-central-1b"]
}

variable "aws_igw_name" {
  type    = string
  default = "Gatewayx"
}

variable "aws_rt_name" {
  type    = string
  default = "route_tablex"
}
