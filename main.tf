# Resource group - used to represent the infrastructure that you want to deploy
# Contains resource type and name
resource "azurerm_resource_group" "app_grp" {
  name = "app-grp"
  location = "East US"
}

# Example resource - This is a storage account
resource "azurerm_storage_account" "storage_account" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.app_grp
  location                 = azurerm_resource_group.app_grp.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}

# Container
resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

# Blob
resource "azurerm_storage_blob" "example" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "some-local-file.zip"
}

#
