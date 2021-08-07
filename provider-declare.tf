terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.71"
    }
  }
  required_version = ">= 1.0.4"
}
provider "azurerm" {
  features {}
  subscription_id = "xxxxxx"
}

