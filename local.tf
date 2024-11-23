locals {
  rg_count = 3
  region_name = var.environment == "prod" ? "westus" : "eastus"
  rg_name = [for i in range(local.rg_count) : format("vel-%s-%s-%s", var.environment, local.region_name, i+1)]
  
}