# Azure Virtual Network
#
# Variables


variable "location" {
  type    = string
  default = "UK South"
}

variable "network_interface_name" {
  type    = string
  default = "network_interface"
}

variable "ip_config_name" {
  type    = string
  default = "ip_config"
}

variable "pv_ip_allocation_type" {
  type    = string
  default = "Dynamic"
}
