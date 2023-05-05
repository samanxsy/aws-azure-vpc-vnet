output "storage-access-key1" {
    value = azurerm_storage_account.storage.primary_access_key
    sensitive = true
}
