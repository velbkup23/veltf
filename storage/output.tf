output "storage_account_id" {
  value = azurerm_storage_account.velstorage.id
}

output "storage_account_name" {
  value = azurerm_storage_account.velstorage.name
}

output "primary_access_key" {
  value     = azurerm_storage_account.velstorage.primary_access_key
  sensitive = true
}

output "secondary_access_key" {
  value     = azurerm_storage_account.velstorage.secondary_access_key
  sensitive = true
}