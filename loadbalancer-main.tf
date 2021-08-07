# Creating Public IP Loadbalancer 
resource "azurerm_public_ip" "lb-tier1-pubip" {
  name                         = "lb-tier1-pubip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-main.name
  sku                 = "Standard"
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30
}

# Creating Front End Load Balancer
resource "azurerm_lb" "lb-tier1" {
  name                = "lb-tier1"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-main.name
  sku = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb-tier1-pubip.id
  }
}

# Creating Back End Address Pool
resource "azurerm_lb_backend_address_pool" "lb-tier1-bp" {
  loadbalancer_id     = azurerm_lb.lb-tier1.id
  name                = "BackEndAddressPool"
}

# Creating Load Balancer Rule
resource "azurerm_lb_rule" "lb-tier1-rule" {
resource_group_name = azurerm_resource_group.rg-main.name
  loadbalancer_id     = azurerm_lb.lb-tier1.id
  name                           = "HTTPRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.lb-tier1-bp.id
  probe_id                       = azurerm_lb_probe.lb-tier1-probe.id
  disable_outbound_snat          = true
}

# Creating Load Balancer Health Probe
resource "azurerm_lb_probe" "lb-tier1-probe" {
  resource_group_name = azurerm_resource_group.rg-main.name
  loadbalancer_id     = azurerm_lb.lb-tier1.id
  name                = "http-probe"
  protocol            = "Http"
  request_path        = "/"
  port                = 80
  #interval_in_seconds = 60
}