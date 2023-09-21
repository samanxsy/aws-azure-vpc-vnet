# EC2 Instance
#
# Variables


# Instance Info
variable "machine_image" {
  description = "AMI for the instance"
  type    = string
  default = "ami-0ec7f9846da6b0f61"
}


variable "instance_type" {
  description = "Istance Type"
  type    = string
  default = "t2.micro"
}

variable "public_ip_required" {
  description = "Define if the instance needs a Public IP or not"
  type = bool
  default = true 
}


# Instance Networking
variable "instance_az" {
  type    = string
  default = "eu-central-1a"
}

variable "subnet_id" {
  type = string
}

variable "ec2_security_group" {
  type = list(string)
}


# Instance Volume
variable "root_block_volume_size" {
  description = "The size of the root block for the EC2 instance"
  type = number
  default = 50
}

variable "encrypt_the_root_block" {
  description = "Encryption for the root block of the instance"
  type = bool
  default = true
}


# Instance Connection
variable "instance_connection_type" {
  type = string
  default = "ssh"
}

variable "instance_username" {
  type = string
  default = "ubuntu"
}

variable "ssh_key_name" {
  description = "ssh key name"
  type = string
}

variable "instance_tags" {
  type = object({
    Name = string
    Env = string
  })
}
