# Azure Resource Group
#
# Main Terraform Config


resource "azurerm_resource_group" "vx_resources" {
  name     = var.rg_name
  location = var.rg_location
}
