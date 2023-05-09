output "resource_group_name" {
  value = azurerm_resource_group.jenkins_vm_rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.jenkins_vm_rg.location
}

output "subnet_id" {
  value = azurerm_subnet.jenkins_subnet.id
}
