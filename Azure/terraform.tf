# Terraform Configs for Azure infrastructure
#
# Project: Ephemeral Cloud Infrastructure
#
# Project: Ephemeral Cloud Infrastructure
#
# Author: Saman Saybani

terraform {
  cloud {
    organization = "samanxdevexp"
    workspaces {
      name = "azure-cloudenv"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.73.0"
    }
  }
}

provider "azurerm" {
  features {}
}
