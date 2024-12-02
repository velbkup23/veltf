terraform {
  required_version = "~> 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.11.0"
    }

    random = {
      source = "hashicorp/random"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "349ac592-a66a-4824-bab6-a69dd26685a0"
  
}

data "azurerm_client_config" "sub_details" {}