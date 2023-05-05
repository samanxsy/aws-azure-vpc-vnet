## Resource Group
resource "azurerm_resource_group" "xvm_group" {
    name = "xvm_rg"
    location = "UK South"
}

## Virtual Network
resource "azurerm_virtual_network" "xv_net" {
    name = "xv_net"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.xvm_group.location
    resource_group_name = azurerm_resource_group.xvm_group.name
}

## Subnet
resource "azurerm_subnet" "xv_subnet" {
    name = "xv_subnet"
    address_prefixes = ["10.0.1.0/24"]
    resource_group_name = azurerm_resource_group.xvm_group.name
    virtual_network_name = azurerm_virtual_network.xv_net.name
}

## Public IP Address
resource "azurerm_public_ip" "xvm_public_ip" {
    name = "xvm_public_ip"
    location = azurerm_resource_group.xvm_group.location
    resource_group_name = azurerm_resource_group.xvm_group.name
    allocation_method = "Dynamic"
}

## Network Interface
resource "azurerm_network_interface" "x_network_interface" {
    name = "x_network_interface"
    location = azurerm_virtual_network.xv_net.location
    resource_group_name = azurerm_resource_group.xvm_group.name

    ip_configuration {
      name = "xvm_ipconfig"
      subnet_id = azurerm_subnet.xv_subnet.id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.xvm_public_ip.id
    }
}
