# Azure Firewall
resource "azurerm_firewall" "aks_firewall" {
  name                = "aks-firewall"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  sku_name            = "AZFW_VNet"
  sku_tier = "standard"

ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }

  rule_collection_group {
    name = "network-rule-collection-group"

    rule_collection {
      name     = "AllowWebTraffic"
      priority = 100
      action   = "Allow"

      rule {
        name                  = "AllowHTTPS"
        protocol              = "Https"
        source_addresses      = ["0.0.0.0/0"]
        destination_addresses = ["*"]
        destination_ports     = ["443"]
      }
    }
  }
}
