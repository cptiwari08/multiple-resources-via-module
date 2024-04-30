resource "azurerm_public_ip" "Load-Balance-PIP" {
  name                = "test-lb-ip"
  location            = "eastus"
  resource_group_name = "cptiwari-rg"
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "LoadBalancer" {
  name                = "test-lb"
  location            = "eastus"
  resource_group_name = "cptiwari-rg"
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.Load-Balance-PIP.id
  }
}

resource "azurerm_lb_backend_address_pool" "backendpool" {
  name            = "test-backendpool"
  loadbalancer_id = azurerm_lb.LoadBalancer.id
}

resource "azurerm_lb_backend_address_pool_address" "backendnginx01" {
  name                    = "backendnginx01"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backendpool.id
  virtual_network_id      = data.azurerm_virtual_network.cptvnet.id
  ip_address              = "10.0.1.4"
}

resource "azurerm_lb_backend_address_pool_address" "backendnginx02" {
  name                    = "backendnginx02"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backendpool.id
  virtual_network_id      = data.azurerm_virtual_network.cptvnet.id
  ip_address              = "10.0.2.4"
}

resource "azurerm_lb_probe" "lb-healthprob" {
  name            = "health-prob"
  loadbalancer_id = azurerm_lb.LoadBalancer.id
  protocol        = "Http"
  port            = 80
  request_path    = "/"
}

resource "azurerm_lb_rule" "LB-Rule" {
  name                           = "lb_rules"
  protocol                       = "Tcp"
  loadbalancer_id                = azurerm_lb.LoadBalancer.id
  frontend_ip_configuration_name = "lb-pip"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backendpool.id]
  probe_id                       = azurerm_lb_probe.lb-healthprob.id
  frontend_port                  = 80
  backend_port                   = 80
}