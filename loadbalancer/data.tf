data "azurerm_lb" "Load-Balancer" {
  name                = "test-lb"
  resource_group_name = "sunil-baba-rg"
}

data "azurerm_lb_backend_address_pool" "backend-pool" {
  name            = "first"
  loadbalancer_id = data.azurerm_lb.Load-Balancer.id
}

data "azurerm_virtual_machine" "virtual_machine" {
  for_each = var.VM
  name                = each.value.name_VM
  resource_group_name = var.rg_map
}