variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "volume_device_name" {
  type    = string
  default = "/dev/sda"
}

variable "aws_instance_name" {
  type    = string
  default = "instancex"
}
