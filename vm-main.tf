resource "azurerm_windows_virtual_machine" "win01" {
  name                = "win01"
  location                = var.location
  resource_group_name     = azurerm_resource_group.rg-main.name
  size                = var.win_compute_size
  admin_username      = var.win_admin_name
  admin_password      = var.win_admin_pass
  network_interface_ids = [
    azurerm_network_interface.win01-nic01.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.win_sku
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "lin01" {
  name                            = "lin01"
  location                = var.location
  resource_group_name     = azurerm_resource_group.rg-main.name
  size                            = var.lin_compute_size
  disable_password_authentication = false
  admin_username                  = var.lin_admin_name
  admin_password                  = var.lin_admin_pass
  network_interface_ids           = [
              azurerm_network_interface.lin01-nic01.id,
            ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = var.lin_offer
    sku       = var.lin_sku
    version   = "latest"
  }
}