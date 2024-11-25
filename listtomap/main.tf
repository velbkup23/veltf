terraform {
  required_version = ">1.9.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "349ac592-a66a-4824-bab6-a69dd26685a0"
}

locals {
  rgdets = [
    {
      name     = "listtomap1"
      location = "eastus"
    },

    {
      name     = "listtomap2"
      location = "westus"
    },

    {
      name     = "listtomap3"
      location = "centralindia"
    }
  ]
}

resource "azurerm_resource_group" "listtomap" {
  for_each = { for idx, rg in local.rgdets : idx => rg }
  name     = each.value.name
  location = each.value.location

}