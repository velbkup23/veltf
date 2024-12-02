terraform {
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

data "azurerm_client_config" "sub_details" {}

resource "azurerm_resource_group" "st_fsl" {
  count    = var.rg_count
  name     = format("velst-%s-%03d", var.location, count.index+1)
  location = var.location
}
