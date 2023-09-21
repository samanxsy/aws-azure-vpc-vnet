# Azure Virtual Network
#
# Main Terraform Config


# Vnet
resource "azurerm_virtual_network" "vx_vnet" {
  name                = var.virtual_network_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_range
}

# Subnet
resource "azurerm_subnet" "vx_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vx_vnet.name
  address_prefixes     = var.subnet_range
}

# Security Group
resource "azurerm_network_security_group" "vx_sg" {
  name                = var.sg_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

# Inbbound Rule 1
resource "azurerm_network_security_rule" "vx_security_rules_SSH" {
  name                        = "vx-security-rules-SSH"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = var.my_ip
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vx_sg.name
}

# Inbound Rule 2
resource "azurerm_network_security_rule" "vx_security_rules_HTTP" {
  name                        = "vx-security-rules-HTTP"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = var.my_ip
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vx_sg.name
}

# Outbound Rule
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
resource "azurerm_network_interface" "vx_network_interface" {
  name                = var.network_interface_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  ip_configuration {
    name                          = var.ip_config_name
    subnet_id                     = azurerm_subnet.vx_subnet.id
    private_ip_address_allocation = var.pv_ip_allocation_type
    public_ip_address_id          = azurerm_public_ip.vx_public_ip.id
  }
}


resource "azurerm_public_ip" "vx_public_ip" {
  name                = var.public_ip_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_type
  sku                 = var.public_ip_sku
}
