resource "azurerm_resource_group" "velrg" {
  count = local.rg_count
  name = local.rg_name[count.index]
  location = local.region_name
}