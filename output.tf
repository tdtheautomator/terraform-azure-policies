
output "Windows-VM-IP" {
  value = azurerm_public_ip.win01-pubip01.ip_address
}

output "Linux-VM-IP" {
  value = azurerm_public_ip.lin01-pubip01.ip_address
}

output "Load-Balancer-IP" {
  value = azurerm_public_ip.lb-tier1-pubip.ip_address
}