# Azure Virtual Network
#
# Outputs


output "subnet_id" {
  value = azurerm_subnet.vx_subnet.id
}

output "network_security_group_id" {
  value = azurerm_network_security_group.vx_sg.id
}

output "network_interface_ids" {
  value = azurerm_network_interface.vx_network_interface[*].id
}
