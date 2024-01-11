# Local variable - used when you reuse declared values
locals {
  resource_group = "app-grp"
  location = "East US"
}
# Resource group - used to represent the infrastructure that you want to deploy
# Contains resource type and name
resource "azurerm_resource_group" "app_grp" {
  name = local.resource_group
  location = local.location
}

# Example resource - This is a storage account
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = local.resource_group
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
  depends_on = [
    azurerm_resource_group.app_grp
  ]
}

# Container
resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = var.storage_account_name
  container_access_type = "blob"
  depends_on = [
    azurerm_storage_account.storage_account
  ]
}

# Blob
resource "azurerm_storage_blob" "sample" {
  name                   = "sample.txt"
  storage_account_name   = var.storage_account_name
  storage_container_name = azurerm_storage_container.data.name
  type                   = "Block"
  source                 = "sample.txt"
  depends_on = [
    azurerm_storage_container.data
  ]
}

# Virtual Network
resource "azurerm_virtual_network" "app_network" {
  name                = "app-network"
  location            = local.location
  resource_group_name = azurerm_resource_group.app_grp.name
  address_space       = ["10.0.0.0/16"]
  # dns_servers         = ["10.0.0.4", "10.0.0.5"] - using azure dns servers

  subnet {
    name           = "SubnetA"
    address_prefix = "10.0.1.0/24"
  }
}



