
# Creating VNet
resource "azurerm_virtual_network" "vnet-main" {
  name                = "vnet-${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-main.name
  address_space       = [var.vnet_cidr]
}

# Creating Subnets
resource "azurerm_subnet" "bastion-subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg-main.name
  virtual_network_name = azurerm_virtual_network.vnet-main.name
  address_prefixes     = [var.bastion_subnet_cidr]
}

resource "azurerm_subnet" "tier1-subnet" {
  name                 = "tier1-subnet"
  resource_group_name  = azurerm_resource_group.rg-main.name
  virtual_network_name = azurerm_virtual_network.vnet-main.name
  address_prefixes     = [var.tier1_subnet_cidr]
}

resource "azurerm_subnet" "tier2-subnet" {
  name                 = "tier2-subnet"
  resource_group_name  = azurerm_resource_group.rg-main.name
  virtual_network_name = azurerm_virtual_network.vnet-main.name
  address_prefixes     = [var.tier2_subnet_cidr]
}


# Creating NSGs
resource "azurerm_network_security_group" "tier1-nsg" {
  name                = "tier1-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-main.name
}

resource "azurerm_network_security_group" "tier2-nsg" {
  name                = "tier2-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-main.name
}


resource "azurerm_subnet_network_security_group_association" "asso-tier1-nsg" {
  subnet_id                 = azurerm_subnet.tier1-subnet.id
  network_security_group_id = azurerm_network_security_group.tier1-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "asso-tier2-nsg" {
  subnet_id                 = azurerm_subnet.tier2-subnet.id
  network_security_group_id = azurerm_network_security_group.tier2-nsg.id
}


# NSG Rules tier-nsg

resource "azurerm_network_security_rule" "tier1-internet-out" {
  name                        = "tier1-internet-out"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "Internet"
  resource_group_name         = azurerm_resource_group.rg-main.name
  network_security_group_name = azurerm_network_security_group.tier1-nsg.name
}

resource "azurerm_network_security_rule" "tier1-http-in" {
  name                        = "tier1-http-in"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-main.name
  network_security_group_name = azurerm_network_security_group.tier1-nsg.name
}

resource "azurerm_public_ip" "win01-pubip01" {
  name                    = "win01-pubip01"
  location                = var.location
  resource_group_name     = azurerm_resource_group.rg-main.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}

resource "azurerm_public_ip" "lin01-pubip01" {
  name                    = "lin01-pubip01"
  location                = var.location
  resource_group_name     = azurerm_resource_group.rg-main.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}

resource "azurerm_network_interface" "win01-nic01" {
  name                = "win01-nic01"
  location                = var.location
  resource_group_name     = azurerm_resource_group.rg-main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.tier2-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.win01-pubip01.id
  }
}

resource "azurerm_network_interface" "lin01-nic01" {
  name                = "lin01-nic01"
  location                = var.location
  resource_group_name     = azurerm_resource_group.rg-main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.tier2-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.lin01-pubip01.id
  }
}



resource "azurerm_network_security_rule" "allow-rdp" {
  name                        = "allow-rdp"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name = azurerm_resource_group.rg-main.name
  network_security_group_name = azurerm_network_security_group.tier2-nsg.name
}

resource "azurerm_network_security_rule" "allow-ssh" {
  name                        = "allow-ssh"
  priority                    = 201
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name = azurerm_resource_group.rg-main.name
  network_security_group_name = azurerm_network_security_group.tier2-nsg.name
}