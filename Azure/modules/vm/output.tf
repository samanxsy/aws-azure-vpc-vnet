output "vm_name" {
  value = azurerm_virtual_machine.xvm.name
}

output "vm_public_ip" {
  value = azurerm_virtual_machine.xvm.vm_public_ip
}
