# Azure Resource Group
#
# Outputs


output "resource_group_location" {
  value = azurerm_resource_group.vx_resources.location
}

output "resource_group_name" {
  value = azurerm_resource_group.vx_resources.name
}
