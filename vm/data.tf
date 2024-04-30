data "azurerm_key_vault_secret" "tiwari_username" {
  name         = "cptusername"
  key_vault_id = data.azurerm_key_vault.keyvault_name.id
}

data "azurerm_key_vault_secret" "tiwari_password" {
  name         = "cptpassword"
  key_vault_id = data.azurerm_key_vault.keyvault_name.id
}


data "azurerm_key_vault" "keyvault_name" {
  name                = "tiwari-secrets008"
  resource_group_name = "cptiwari-rg"
}

data "azurerm_subnet" "subnet-block" {
  for_each             = var.VM
  name                 = "frontend-subnet"
  virtual_network_name = each.value.location
  resource_group_name  = each.value.resource_group_name
}

# data "azurerm_network_interface" "nic_block" {
#   name                = "sunil-nic01"
#   resource_group_name = "sunil-baba-rg"
# }
