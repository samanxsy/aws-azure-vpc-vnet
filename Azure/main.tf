# Main Terraform Configs
#
# Project: Ephemeral Azure infrastructure
#
# Author: Saman Saybani


module "virtual_machine" {
  source = "./modules/virtual_machine"

  # VM Info
  virtual_machine_name = "vx-vm"

  # Storage
  delete_data_on_termination = true
  delete_os_on_termination   = true
  storage_os_name            = "vx_os_disk"
  storage_os_caching         = "ReadWrite"
  storage_os_creation        = "FromImage"
  storage_os_disk_type       = "Standard_LRS"

  # Image
  image_publisher = "Canonical"
  image_offering  = "UbuntuServer"
  image_sku       = "22.04-LTS"
  image_version   = "latest"

  # Profile
  machine_name     = "vx_machine"
  username         = "saman"
  disable_password = true
  ssh_key_path     = "/home/vxadmin/.ssh/authorized_keys"

  # Networking
  network_interface_ids = module.virtual_network.network_interface_ids

  # Resource Group
  resource_group_name     = module.resource_group.resource_group_name
  resource_group_location = module.resource_group.resource_group_location
}


module "virtual_network" {
  source = "./modules/virtual_network"

  # VNET
  virtual_network_name   = "vx-vnet"
  vnet_address_range     = ["10.0.0.0/16"]
  network_interface_name = "vx-ni"

  # Subnet
  subnet_name  = "vx-subnet"
  subnet_range = ["10.0.1.0/24"]
  sg_name      = "vx-sg"

  # IP
  ip_config_name            = "vx-ipconfig"
  pv_ip_allocation_type     = "Dynamic"
  public_ip_allocation_type = "Dynamic"
  public_ip_name            = "vx-public-ip"
  public_ip_sku             = "Basic"

  # Resource Group
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name     = module.resource_group.resource_group_name

  # Rules
  my_ip = data.external.my_public_ip
}

module "resource_group" {
  source = "./modules/resource_group"
}


data "external" "my_public_ip" {
  program = ["bash", "./modules/virtual_network/get_ip.sh"]
}
