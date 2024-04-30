resource "azurerm_virtual_network" "cptvnet" {
  for_each            = var.vnet_map
  name                = each.value.vnet_name
  location            = each.value.vnet_location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
}