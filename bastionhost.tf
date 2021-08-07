
# Creating Public IP for Bastion Host
resource "azurerm_public_ip" "bastion-pubip" {
  name                      = "bastion-pubip"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg-main.name
  sku         = "Standard"
  allocation_method         = "Static"
  idle_timeout_in_minutes   = 30
}

# Creating Bastion Host
resource "azurerm_bastion_host" "bastion-host" {
  name                = "bastion-host"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg-main.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion-subnet.id
    public_ip_address_id = azurerm_public_ip.bastion-pubip.id
  }
}