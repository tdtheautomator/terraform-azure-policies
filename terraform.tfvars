location = "westus2"

vnet_cidr = "10.10.0.0/16"
bastion_subnet_cidr = "10.10.50.0/24"
tier1_subnet_cidr = "10.10.10.0/24"
tier2_subnet_cidr = "10.10.20.0/24"


win_admin_name = "vmadmin"
win_admin_pass = "xxxxxx"
win_compute_size = "Standard_B2s"
win_sku = "2019-Datacenter"

lin_admin_name = "vmadmin"
lin_admin_pass = "xxxxxx"
lin_compute_size = "Standard_B2s"
lin_offer = "UbuntuServer"
lin_sku = "16.04-LTS"

vmss-tier1-prefix = "vm-tier1"