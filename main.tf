provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "aks_rg" {
  name     = "my-aks-resource-group"
  location = "East US"
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "my-aks-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
}

# Subnet
resource "azurerm_subnet" "aks_subnet" {
  name                 = "my-aks-subnet"
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "myaks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    dns_service_ip = "10.0.2.10"
    service_cidr = "10.0.2.0/24"
  }

  tags = {
    Environment = "Development"
  }
}

# Output the AKS cluster details
output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

# Create Azure Key Vault
resource "azurerm_key_vault" "example" {
  name                        = "my-keyvault"
  location                    = azurerm_resource_group.aks_rg.location
  resource_group_name          = azurerm_resource_group.aks_rg.name
  tenant_id                   = data.azurerm_client_config.example.tenant_id
  sku_name                    = "standard"

  # Access policies can be managed here for specific users or services
}

# Create a secret in Key Vault
resource "azurerm_key_vault_secret" "example" {
  name         = "aks-service-principal"
  value        = jsonencode({
    client_id     = var.client_id,
    client_secret = var.client_secret
  })
  key_vault_id = azurerm_key_vault.example.id
}

