resource "azurerm_virtual_machine" "xvm" {
    name = "xvm"
    location = module.vnet.xvm_group_location
    resource_group_name = module.vnet.xvm_resource_group
    network_interface_ids = module.vnet.network_interface_id
    vm_size = "Standard_B1s"

    storage_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "22.04-LTS"
        version = "latest"
    }

    os_disk {
        name = "xvm_disk"
        caching = "ReadWrite"
        create_option = "FromImage"
        managed_disk_type = "Standard_LRS"
        disk_size_gb = "30"
    }

    delete_data_disks_on_termination = true

    os_profile {
      admin_username = "ubuntu"
    }

    admin_ssh_key {
        username = "ubuntu"
        public_key = file("./modules/vm/vmkey.pub")
    }
}
