# Azure Virtual Network
#
# Variables

# Vnet
variable "virtual_network_name" {
  type    = string
  default = "default_vm"
}

variable "vnet_address_range" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "network_interface_name" {
  type    = string
  default = "network_interface"
}

# Subnet
variable "subnet_name" {
  type    = string
  default = "default_subnet"
}

variable "subnet_range" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "sg_name" {
  type    = string
  default = "default_sg"
}


# IP
variable "ip_config_name" {
  type    = string
  default = "ip_config"
}

variable "pv_ip_allocation_type" {
  type    = string
  default = "Dynamic"
}

variable "public_ip_allocation_type" {
  type    = string
  default = "Dynamic"
}

variable "public_ip_name" {
  type    = string
  default = "public-ip"
}

variable "public_ip_sku" {
  type    = string
  default = "Basic"
}


# Resource Group
variable "resource_group_location" {
  type = string
}

variable "resource_group_name" {
  type = string

}

# Rules
variable "my_ip" {
  type = string
}