resource "random_string" "namesuf" {
  length  = 3
  upper   = false
  special = false
}

resource "azurerm_storage_account" "velstorage" {
  name                = format("velst%s%s%s", substr(var.location, 0, 3), var.appname, random_string.namesuf.result)
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  account_kind                  = var.account_kind
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "share_properties" {
    for_each = (var.account_kind == "FileStorage" && var.account_tier == "Premium") ? [1] : []

    content {
      retention_policy {
        days = 30
      }

      smb {
        versions             = ["SMB3.0", "SMB3.1.1"]
        multichannel_enabled = true
      }
    }
  }

  dynamic "blob_properties" {
    for_each = (var.account_kind == "BlobStorage") ? [1] : []

    content {
      delete_retention_policy {
        days = 30
      }
    }
  }


}

