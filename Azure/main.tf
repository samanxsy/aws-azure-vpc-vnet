terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.31.1"
    }
  }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "RG" {
    name = "backened-rg"
    location = "East US"
}

resource "azurerm_storage_account" "storage" {
    name = "vxstorageaccount"
    resource_group_name = azurerm_resource_group.RG.name
    location = azurerm_resource_group.RG.location
    account_tier = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storagecontainer" {
    name = "vxstoragecontainer"
    storage_account_name = azurerm_storage_account.storage.name
    container_access_type = "private"
}

module "vnet" {
  source = "./modules/vnet"
}

module "vm" {
  source = "./modules/vm"
  depends_on = [ module.vnet ]
}
