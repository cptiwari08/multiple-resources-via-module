data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "keyvault_name" {
  name                = "tiwarisecrets008"
  resource_group_name = "sunil-baba-rg"
}

data "azurerm_key_vault_secret" "tiwari_username" {
  name         = "sunilbabuusername"
  key_vault_id = data.azurerm_key_vault.keyvault_name.id
}

data "azurerm_key_vault_secret" "tiwari_password" {
  name         = "sunilbabupassword"
  key_vault_id = data.azurerm_key_vault.keyvault_name.id
}

