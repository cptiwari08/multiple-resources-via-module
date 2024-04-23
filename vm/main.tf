resource "azurerm_network_interface" "nic" {
  for_each            = var.VM
  name                = "sunil-nic01"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  ip_configuration {
    name                          = each.value.name_ip
    subnet_id                     = data.azurerm_subnet.subnet-block.id
    private_ip_address_allocation = each.value.private_ip_address_allocation

  }
}

resource "azurerm_virtual_machine" "virtual_machine" {
  for_each            = var.VM
  name                = each.value.name_VM
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]
  vm_size = each.value.vm_size


  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = each.value.name_disk
    caching           = each.value.caching
    create_option     = each.value.create_option
    managed_disk_type = each.value.managed_disk_type
  }
  os_profile {
    computer_name  = each.value.computer_name
    admin_username = data.azurerm_key_vault_secret.tiwari_username.value
    admin_password = data.azurerm_key_vault_secret.tiwari_password.value
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

}
