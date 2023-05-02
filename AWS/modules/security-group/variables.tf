variable "my_ip" {
    description = "The IP address of your machine to allow SSH access"
}

variable "aws_security_group_prefix" {
    default = "sgx"
}
