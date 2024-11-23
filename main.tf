terraform {
  required_version = "~1.9.0"

  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        required_version = "4.11.0"
    }
  }
}

provider "azurerm" {
  features {}
}