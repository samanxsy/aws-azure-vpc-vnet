# Azure Virtual Machine
#
# Main Terraform Config


resource "azurerm_virtual_machine" "vx_vm" {
  name                  = var.virtual_machine_name
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = var.network_interface_ids
  vm_size               = var.virtual_machine_size

  delete_data_disks_on_termination = var.delete_data_on_termination
  delete_os_disk_on_termination    = var.delete_os_on_termination

  storage_os_disk {
    name              = var.storage_os_name
    caching           = var.storage_os_caching
    create_option     = var.storage_os_creation
    managed_disk_type = var.storage_os_disk_type
  }

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offering
    sku       = var.image_sku
    version   = var.image_version
  }


  os_profile {
    computer_name  = var.machine_name
    admin_username = var.username
  }

  os_profile_linux_config {
    disable_password_authentication = var.disable_password
    ssh_keys {
      path     = var.ssh_key_path
      key_data = file("modules/virtual_machine/vmkey.pub")
    }
  }
}
