# EBS
#
# Variables


variable "ebs_az" {
  description = "Availability Zone for the EBS"
  type        = string
  default     = "eu-central-1a"
}

variable "ebs_size" {
  description = "Size of the EBS volume"
  type        = number # 20
}

variable "encrypt_ebs" {
  description = "Encryption for the EBS volume"
  type        = bool
  default     = true
}

variable "ebs_tags" {
  description = "EBS tags"
  type = object({
    Name = string
    Env  = string
  })
}
