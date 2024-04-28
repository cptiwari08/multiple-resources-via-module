resource "azurerm_public_ip" "Load-Balance-PIP" {
  name                = "test-lb-ip"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_lb" "Load-Balancer" {
  name                = "test-lb"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.Load-Balance-PIP.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend-pool" {
  name                = "test-backendpool"
  loadbalancer_id     = data.azurerm_lb.Load-Balancer.id
}

resource "azurerm_network_interface_backend_address_pool_association" "pool-assosiation" {
    for_each = var.lb_map
  count                   = 2
  network_interface_id    = azurerm_network_interface.nic[count.index].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.pool-assosiation.id
}

# # resource "azurerm_network_interface" "nic" {
# #   count                = 2
# #   name                 = "example-nic-${count.index}"
# #   location             = azurerm_resource_group.example.location
# #   resource_group_name  = azurerm_resource_group.example.name

# #   ip_configuration {
# #     name                          = "internal"
# #     subnet_id                     = azurerm_subnet.example.id
# #     private_ip_address_allocation = "Dynamic"
# #   }
# }


resource "azurerm_lb_probe" "lb-healthprob" {
    for_each = var.lb_map
  name                = "health-prob"
  loadbalancer_id     = azurerm_lb.Load-Balancer.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
}

resource "azurerm_lb_rule" "LB-Rule" {
    for_each = var.lb_map
  name                         = "lb_rules"
  protocol                       = "Tcp"
  loadbalancer_id              = data.azurerm_lb.Load-Balancer.id
  frontend_ip_configuration_name = "lb-pip"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend-pool.id]
  probe_id                     = azurerm_lb_probe.lb-healthprob.id
  frontend_port                = 80
  backend_port                 = 80
}

# output "public_ip_address" {
#   value = azurerm_public_ip.example.ip_address
# }
