terraform {

  required_version = ">1.9"

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
  rglist = {
    test1  = "/subscriptions/349ac592-a66a-4824-bab6-a69dd26685a0/resourceGroups/test1"
    test2  = "/subscriptions/349ac592-a66a-4824-bab6-a69dd26685a0/resourceGroups/test2"
    test3  = "/subscriptions/349ac592-a66a-4824-bab6-a69dd26685a0/resourceGroups/test3"
  }
}

import {
  for_each = local.rglist
  to       = azurerm_resource_group.testrg[each.key]
  id       = each.value
}

resource "azurerm_resource_group" "testrg" {
  for_each = local.rglist
  name     = each.key
  location = "eastus"
}