resource "random_string" "namesuf" {
  length  = 3
  upper   = false
  special = false
}

resource "azurerm_resource_group" "velstrg" {
  name     = format("velst-rg-%s-%s", var.appname, random_string.namesuf.result)
  location = var.location
}

module "FileStorage" {
  source = "../storage"

  for_each = {
    for st in [
      for item in local.flattened_storage_resources : {
        resource_type     = item.resource_type
        resource_name     = item.resource_name
        resource_seq      = item.resource_seq
      }
    ] : "${st.resource_type}-${st.resource_name}-${st.resource_seq}" => st
  }

  resource_group_name = azurerm_resource_group.velstrg.name

  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  appname                  = substr(each.value.resource_type, 0, 3)
  location                 = var.location

}

/* module "FileStorage" {
  source = "../storage"

  for_each = {
    for st in distinct([
      for item in local.flattened_storage_resources : {
        resource_type = item.resource_type
        resource_name = item.resource_name
      }
    ]) : "${st.resource_type}-${st.resource_name}" => st
  }

  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  appname                  = substr(each.value.resource_type, 0, 3)
  location                 = var.location

} */

resource "azurerm_storage_share" "fsl_fileshares" {
  for_each = module.FileStorage

  name               = format("fsl-%s-001", length(try(regex(".*off.*", each.value.storage_account_name), ""))>0 ? "fsl-odfc" : "fsl-prof")
  storage_account_id = each.value.storage_account_id
  quota              = 100
}