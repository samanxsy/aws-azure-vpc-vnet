output "xvm_resource_group" {
    value = azurerm_resource_group.xvm_group.name
}

output "xvm_group_location" {
    value = azurerm_resource_group.xvm_group.location
}

output "network_interface_id" {
    value = azurerm_network_interface.x_network_interface.id
}

