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


resource "azurerm_network_security_group" "jenkins_sg" {
  name                = "jenkins-sg"
  location            = azurerm_resource_group.jenkins_vm_rg.location
  resource_group_name = azurerm_resource_group.jenkins_vm_rg.name
}

resource "azurerm_network_security_rule" "jenkins_security_rules_SSH" {
  name                        = "jenkins-security-rules-SSH"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.jenkins_vm_rg.name
  network_security_group_name = azurerm_network_security_group.jenkins_sg.name
}

resource "azurerm_network_security_rule" "jenkins_security_rules_HTTP" {
  name                        = "jenkins-security-rules-HTTP"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8080"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.jenkins_vm_rg.name
  network_security_group_name = azurerm_network_security_group.jenkins_sg.name
}

resource "azurerm_network_security_rule" "jenkins_security_rules_outbound" {
  name                        = "jenkins-security-rules-outbound"
  priority                    = 1003
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.jenkins_vm_rg.name
  network_security_group_name = azurerm_network_security_group.jenkins_sg.name
}


resource "azurerm_subnet_network_security_group_association" "jenkins_subnet_nsg" {
  subnet_id = azurerm_subnet.jenkins_subnet.id
  network_security_group_id = azurerm_network_security_group.jenkins_sg.id
}
