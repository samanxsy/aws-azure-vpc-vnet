# Azure Virtual Network
#
# Main Terraform Config



resource "azurerm_virtual_network" "vx_vnet" {
  name                = "vx-vnet"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}


resource "azurerm_subnet" "vx_subnet" {
  name                 = "vx-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vx_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}


resource "azurerm_network_security_group" "vx_sg" {
  name                = "vx-sg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}


resource "azurerm_network_security_rule" "vx_security_rules_SSH" {
  name                        = "vx-security-rules-SSH"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = data.external.my_public_ip.result["my_public_ip"]
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vx_sg.name
}

resource "azurerm_network_security_rule" "vx_security_rules_HTTP" {
  name                        = "vx-security-rules-HTTP"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8000"
  source_address_prefix       = data.external.my_public_ip.result["my_public_ip"]
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vx_sg.name
}

resource "azurerm_network_security_rule" "vx_security_rules_outbound" {
  name                        = "vx-security-rules-outbound"
  priority                    = 1003
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vx_sg.name
}


resource "azurerm_subnet_network_security_group_association" "vx_subnet_nsg" {
  subnet_id                 = azurerm_subnet.vx_subnet.id
  network_security_group_id = azurerm_network_security_group.vx_sg.id
}


# Network Interface
resource "azurerm_network_interface" "vx_nic" {
  name                = var.network_interface_name
  resource_group_name = var.var.resource_group_name
  location            = var.var.resource_group_location

  ip_configuration {
    name                          = var.ip_config_name
    subnet_id                     = var.azurerm_subnet.vx_subnet.id
    private_ip_address_allocation = var.pv_ip_allocation_type
    public_ip_address_id          = azurerm_public_ip.vx_public_ip.id
  }
}


resource "azurerm_public_ip" "vx_public_ip" {
  name                = "vx-public-ip"
  location            = var.var.resource_group_location
  resource_group_name = var.var.resource_group_location
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}
