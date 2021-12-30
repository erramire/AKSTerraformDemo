terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg_ope_base_dev"
    storage_account_name = "satfopeaks "
    container_name = "tfstate"
    key = "tf-aks-with-appgwy.tfstate"
  }

  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}