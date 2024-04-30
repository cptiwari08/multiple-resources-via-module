resource "azurerm_storage_account" "storageaccount" {
  for_each                 = var.sa
  name                     = each.value.stg_name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}

# resource "azurerm_storage_container" "container01" {
#   name                  = "tfstate"
#   storage_account_name  = "sa11092023"
#   container_access_type = "private"
# }