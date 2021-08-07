resource "azurerm_resource_group" "rg-main" {
  name     = "rg-${var.location}"
  location = var.location
}