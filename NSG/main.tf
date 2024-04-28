

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg01"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = "allowinbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "nsgaccociation" {
  subnet_id                 = data.azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}