resource "azurerm_resource_group" "jenkins_vm_rg" {
  name     = "jenkins-vm-rg"
  location = var.location
}

resource "azurerm_virtual_network" "jenkins_vnet" {
  name                = "jenkins-vnet"
  location            = azurerm_resource_group.jenkins_vm_rg.location
  resource_group_name = azurerm_resource_group.jenkins_vm_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "jenkins_subnet" {
  name                 = "jenkins-subnet"
  resource_group_name  = azurerm_resource_group.jenkins_vm_rg.name
  virtual_network_name = azurerm_virtual_network.jenkins_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
