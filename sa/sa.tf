terraform {

  required_version = ">=0.12"
  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_storage_account" "tfdevtest" {
  name                     = var.sa_name
  resource_group_name      = var.rg_name
  location                 = var.resource_group_location
  account_tier            = var.account_tier
  account_replication_type = var.account_replication_type

   tags = {
    environment = "Terraform Storage"
    CreatedBy = var.createdBy
      }
  }