# Azure Virtual Machine
#
# Variables


variable "virtual_machine_name" {
	description = "Name of the Virtual Machine"
	type = string
	default = "default_vm"
}

variable "resource_group_location" {
	type = string
}

variable "resource_group_name" {
	type = string
}

variable "network_interface_ids" {
	type = list(string)	
}

variable "virtual_machine_size" {
	type = string
	default = "Standard_B1s"
}

# Storage
variable "delete_data_on_termination" {
	type = bool
	default = true
}

variable "delete_os_on_termination" {
	type = bool
	default = true
}

variable "storage_os_name" {
	type = string
	default = "os_disk"
}

variable "storage_os_caching" {
	type = string
	default = "ReadWrite"
}

variable "storage_os_creation" {
	type = string
	default = "FromImage"
}

variable "storage_os_disk_type" {
	type = string
	default = "Standard_LRS"
}


# Image
variable "image_publisher" {
	type = string
	default = "Canonical"
}

variable "image_offering" {
	type = string
	default = "UbuntuServer"
}

variable "image_sku" {
	type = string
	default = "22.04-LTS"
}

variable "image_version" {
	type = string
	default = "latest"
}


# Profile
variable "machine_name" {
	type = string
	default = "machine-user"
}

variable "username" {
	type = string
	default = "saman"
}

variable "disable_password" {
	type = bool
	default = true
}

variable "ssh_key_path" {
	type = string
	default = "/home/vxadmin/.ssh/authorized_keys"
}
