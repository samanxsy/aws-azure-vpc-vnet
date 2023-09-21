# Azure Resource Group
#
# Variables


variable "rg_name" {
  description = "Name of the Resource Group"
  type        = string
  default     = "Default-RG"
}

variable "rg_location" {
  description = "Location (Region) of the Resource Group"
  type        = string
  default     = "UK South"
}
