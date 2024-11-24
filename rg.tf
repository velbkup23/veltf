resource "random_string" "suffix" {
  count = local.rg_count
  length  = 3
  upper   = false
  special = false
}

resource "azurerm_resource_group" "velrg" {
  count    = local.rg_count
  name     = local.rg_name[count.index]
  location = local.region_name
}