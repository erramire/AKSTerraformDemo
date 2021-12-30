locals {    
    frontend_port_name             = "${var.virtual_network_name}-feport"
    frontend_ip_configuration_name = "${var.virtual_network_name}-feip"    
    backend_address_pool_name      = "${var.virtual_network_name}-beap"
    http_setting_name              = "${var.virtual_network_name}-be-htst"
    listener_name                  = "${var.virtual_network_name}-httplstn"
    request_routing_rule_name      = "${var.virtual_network_name}-rqrt"
}
data "azurerm_subnet" "appgwsubnet" {
    name                 = var.app_gateway_subnet_name
    virtual_network_name = var.virtual_network_name
    resource_group_name  = var.resource_group_name
    depends_on = [azurerm_subnet.appgwy-default]
}

# Public Ip 
resource "azurerm_public_ip" "appgwspublicip" {
    name                         = var.app_gateway_publicip_name
    location                     = var.location
    resource_group_name          = var.resource_group_name
    allocation_method            = "Static"
    sku                          = "Standard"

    tags = var.tags
}

resource "azurerm_application_gateway" "network" {
    name                = var.app_gateway_name
    resource_group_name = var.resource_group_name
    location            = var.location

    sku {
    name     = var.app_gateway_sku
    tier     = var.app_gateway_sku
    capacity = 2
    }

    gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = data.azurerm_subnet.appgwsubnet.id
    }

    frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.appgwspublicip.id
    }

    frontend_port {
    name = local.frontend_port_name
    port = 80
    }

    frontend_port {
    name = "httpsPort"
    port = 443
    }

    backend_address_pool {
    name = local.backend_address_pool_name
    }

    backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
    }

    http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
    }

    request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    }


    tags = var.tags

    depends_on = [azurerm_subnet.appgwy-default, azurerm_public_ip.appgwspublicip]
}

