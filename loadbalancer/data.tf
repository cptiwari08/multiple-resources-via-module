data "azurerm_virtual_network" "cptvnet" {
  name                 = "cpt_vnet"
  resource_group_name  = "cptiwari-rg"
}