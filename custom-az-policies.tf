resource "azurerm_policy_definition" "ap-001-location-ukwest" {
  name = "ap-001-location-ukwest"
  display_name = "ap-001-location-ukwest"
  description = "Audit Policy for Resources Not Deployed in UK West "
  policy_type = "Custom"
  mode = "All"

  policy_rule = <<POLICY_RULE
    {
    "if": {
      "not": {
        "field": "location",
        "equals": "ukwest"
      }
    },
    "then": {
      "effect": "Audit"
    }
  }
POLICY_RULE
}

resource "azurerm_policy_definition" "ap-002-public-rdp" {
  name = "ap-002-public-rdp"
  display_name = "ap-002-public-rdp"
  description = "Audit Policy for RDP Access from Public Domain "
  policy_type = "Custom"
  mode = "All"

  policy_rule = <<POLICY_RULE
    {
    "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Network/networkSecurityGroups/securityRules"
          },
          {
            "allOf": [
              {
                "field": "Microsoft.Network/networkSecurityGroups/securityRules/access",
                "equals": "Allow"
              },
              {
                "field": "Microsoft.Network/networkSecurityGroups/securityRules/direction",
                "equals": "Inbound"
              },
              {
                "anyOf": [
                  {
                    "field": "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange",
                    "equals": "*"
                  },
                  {
                    "field": "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange",
                    "equals": "3389"
                  },
                  {
                    "value": "[if(and(not(empty(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'))), contains(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'),'-')), and(lessOrEquals(int(first(split(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'), '-'))),3389),greaterOrEquals(int(last(split(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'), '-'))),3389)), 'false')]",
                    "equals": "true"
                  },
                  {
                    "count": {
                      "field": "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]",
                      "where": {
                        "value": "[if(and(not(empty(first(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]')))), contains(first(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]')),'-')), and(lessOrEquals(int(first(split(first(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]')), '-'))),3389),greaterOrEquals(int(last(split(first(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]')), '-'))),3389)) , 'false')]",
                        "equals": "true"
                      }
                    },
                    "greater": 0
                  },
                  {
                    "not": {
                      "field": "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]",
                      "notEquals": "*"
                    }
                  },
                  {
                    "not": {
                      "field": "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]",
                      "notEquals": "3389"
                    }
                  }
                ]
              },
              {
                "anyOf": [
                  {
                    "field": "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefix",
                    "equals": "*"
                  },
                  {
                    "field": "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefix",
                    "equals": "Internet"
                  },
                  {
                    "not": {
                      "field": "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefixes[*]",
                      "notEquals": "*"
                    }
                  },
                  {
                    "not": {
                      "field": "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefixes[*]",
                      "notEquals": "Internet"
                    }
                  }
                ]
              }
            ]
          }
        ]
      },
    "then": {
      "effect": "Audit"
    }
  }
POLICY_RULE
}

resource "azurerm_policy_definition" "ap-003-public-ssh" {
  name = "ap-003-public-ssh"
  display_name = "ap-003-public-ssh"
  description = "Audit Policy for SSH Access from Public Domain "
  policy_type = "Custom"
  mode = "All"

  policy_rule = <<POLICY_RULE
    {
    "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Network/networkSecurityGroups/securityRules"
          },
          {
            "allOf": [
              {
                "field": "Microsoft.Network/networkSecurityGroups/securityRules/access",
                "equals": "Allow"
              },
              {
                "field": "Microsoft.Network/networkSecurityGroups/securityRules/direction",
                "equals": "Inbound"
              },
              {
                "anyOf": [
                  {
                    "field": "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange",
                    "equals": "*"
                  },
                  {
                    "field": "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange",
                    "equals": "22"
                  },
                  {
                    "value": "[if(and(not(empty(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'))), contains(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'),'-')), and(lessOrEquals(int(first(split(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'), '-'))),22),greaterOrEquals(int(last(split(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'), '-'))),22)), 'false')]",
                    "equals": "true"
                  },
                  {
                    "count": {
                      "field": "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]",
                      "where": {
                        "value": "[if(and(not(empty(first(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]')))), contains(first(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]')),'-')), and(lessOrEquals(int(first(split(first(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]')), '-'))),22),greaterOrEquals(int(last(split(first(field('Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]')), '-'))),22)) , 'false')]",
                        "equals": "true"
                      }
                    },
                    "greater": 0
                  },
                  {
                    "not": {
                      "field": "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]",
                      "notEquals": "*"
                    }
                  },
                  {
                    "not": {
                      "field": "Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRanges[*]",
                      "notEquals": "22"
                    }
                  }
                ]
              },
              {
                "anyOf": [
                  {
                    "field": "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefix",
                    "equals": "*"
                  },
                  {
                    "field": "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefix",
                    "equals": "Internet"
                  },
                  {
                    "not": {
                      "field": "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefixes[*]",
                      "notEquals": "*"
                    }
                  },
                  {
                    "not": {
                      "field": "Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefixes[*]",
                      "notEquals": "Internet"
                    }
                  }
                ]
              }
            ]
          }
        ]
      },
    "then": {
      "effect": "Audit"
    }
  }
POLICY_RULE
}