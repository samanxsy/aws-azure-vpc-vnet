resource "azurerm_network_interface" "jenkins_nic" {
  name     = "jenkins-nic"
  resource_group_name = var.resource_group_name
  location = var.resource_group_location

  ip_configuration {
    name                          = "jenkins-ip"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jenkins_public_ip.id
  }
}

resource "azurerm_public_ip" "jenkins_public_ip" {
  name                = "jenkins-public-ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# # VIRTUAL MACHINE
resource "azurerm_virtual_machine" "jenkins_vm" {
  name                  = "jenkins-vm"
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.jenkins_nic.id]
  vm_size               = "Standard_B1s"

  storage_os_disk {
    name              = "jenkins-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }


  os_profile {
    computer_name  = "jenkins-vm"
    admin_username = "jenkinsadmin"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/jenkinsadmin/.ssh/authorized_keys"
      key_data = file("vm/vmkey.pub")
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i '${azurerm_public_ip.jenkins_public_ip.ip_address},' vm/jenkins-playbook.yaml --private-key=vm/vmkey"
  }
}
