locals {
  location = "CentralIndia"
  st_account_tier = "Standard"
  st_account_replication_type = "LRS"
  
  rg_count    = 3
  region_name = var.environment == "prod" ? "westus" : "eastus"
  rg_name     = [for i in range(local.rg_count) : format("vel-%s-%s-%s-%s", var.environment, local.region_name, random_string.suffix[i].result, i + 1)]

}