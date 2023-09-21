# Main Terraform Configs
#
# Project: Ephemeral Azure infrastructure
#
# Author: Saman Saybani


module "virtual_machine" {
  source = "./virtual_machine"

  # VM Info
  virtual_machine_name = "vx-vm"

  # Storage
  delete_data_on_termination = true
  delete_os_on_termination = true
  storage_os_name = "vx_os_disk"
  storage_os_caching = "ReadWrite"
  storage_os_creation = "FromImage"
  storage_os_disk_type = "Standard_LRS"

  # Image
  image_publisher = "Canonical"
  image_offering = "UbuntuServer"
  image_sku = "22.04-LTS"
  image_version = "latest"

  # Profile
  machine_name = "vx_machine"
  username = "saman"
  disable_password = true
  ssh_key_path = "/home/vxadmin/.ssh/authorized_keys"

  # Networking
  resource_group_name       = module.virtual_network.resource_group_name
  resource_group_location   = module.virtual_network.resource_group_location
  network_interface_ids = module.virtual_network.network_interface_ids
}


module "virtual_network" {
  source = "./virtual_network"
}


data "external" "my_public_ip" {
  program = ["bash", "vnet/get_ip.sh"]
}
