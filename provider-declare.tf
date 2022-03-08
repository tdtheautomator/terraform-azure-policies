terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.98"
    }
  }
  required_version = ">= 1.1.7"
}
provider "azurerm" {
  features {}
  subscription_id = "xxxxxx"
}

