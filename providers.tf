# Source and version - took out the version block, it will download whatever is current.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0" // ~> means 3.0 and above
    }
  }
}

# Provider block - tells terraform how to manage the infrastructure
# Application object
provider "azureerm" {
  subscription_id = "test1"
  client_id       = "client1" //Application id
  client_secret   = "secret1" //This is like having a password. Create a secret, then copy the value and place here.
  tenant_id       = "tenant1" //Directory ID
  features{}
}
