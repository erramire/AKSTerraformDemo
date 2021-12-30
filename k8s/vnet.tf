resource "azurerm_virtual_network" "aksvnet" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/7"]
}

# Create a Subnet for AKS
resource "azurerm_subnet" "aks-default" {
  name                 = var.aks_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
  address_prefixes     = ["10.240.0.0/16"]
  depends_on = [azurerm_virtual_network.aksvnet]
}

resource "azurerm_subnet" "appgwy-default" {
  name                 = var.app_gateway_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
  address_prefixes     = var.app_gateway_subnet_address_prefix
  depends_on = [azurerm_virtual_network.aksvnet]
}