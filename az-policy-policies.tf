resource "azurerm_resource_group_policy_assignment" "ap-001-location-ukwest" {
  name = azurerm_policy_definition.ap-001-location-ukwest.name
  display_name = azurerm_policy_definition.ap-001-location-ukwest.display_name
  resource_group_id = azurerm_resource_group.rg-main.id
  policy_definition_id = azurerm_policy_definition.ap-001-location-ukwest.id
}

resource "azurerm_resource_group_policy_assignment" "ap-002-public-rdp" {
  name = azurerm_policy_definition.ap-002-public-rdp.name
  display_name = azurerm_policy_definition.ap-002-public-rdp.display_name
  resource_group_id = azurerm_resource_group.rg-main.id
  policy_definition_id = azurerm_policy_definition.ap-002-public-rdp.id
}

resource "azurerm_resource_group_policy_assignment" "ap-003-public-ssh" {
  name = azurerm_policy_definition.ap-003-public-ssh.name
  display_name = azurerm_policy_definition.ap-003-public-ssh.display_name
  resource_group_id = azurerm_resource_group.rg-main.id
  policy_definition_id = azurerm_policy_definition.ap-003-public-ssh.id
}

resource "azurerm_resource_group_policy_assignment" "ap-004-managed-disk" {
    name = "ap-004-managed-disk"
    resource_group_id = azurerm_resource_group.rg-main.id
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d"
    description = "Shows all virtual machines not using managed disks"
    display_name = "ap-004-managed-disk"
}

resource "azurerm_resource_group_policy_assignment" "ap-005-admin-accounts" {
    name = "ap-005-admin-accounts"
    resource_group_id = azurerm_resource_group.rg-main.id
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/3d2a3320-2a72-4c67-ac5f-caa40fbee2b2"
    description = "Audit Windows machines that have extra accounts in the Administrators group"
    display_name = "ap-005-admin-accounts"
}

resource "azurerm_resource_group_policy_assignment" "ap-006-encryption-host" {
    name = "ap-006-encryption-host"
    resource_group_id = azurerm_resource_group.rg-main.id
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/fc4d8e41-e223-45ea-9bf5-eada37891d87"
    description = "Virtual machines and virtual machine scale sets should have encryption at host enabled"
    display_name = "ap-006-encryption-host"
}

