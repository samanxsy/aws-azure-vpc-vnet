variable "machine_image" {
  type    = string
  default = "ami-0ec7f9846da6b0f61"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "aws_instance_azs" {
  type    = string
  default = "eu-central-1a"
}

variable "aws_instance_name" {
  type = string
}

variable "aws_subnet_id" {
  type = string
}

variable "ec2_security_group" {
  type = string
}
