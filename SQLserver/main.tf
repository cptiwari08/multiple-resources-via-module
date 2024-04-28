resource "azurerm_mssql_server" "sqlserver" {
  name                         = "shivam-sqlserver"
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = "sqladminstrator"
  administrator_login_password = "Thisisadog11"
  minimum_tls_version          = "1.2"

}

resource "azurerm_mssql_database" "sqldatabase" {
  name           = "shivam-sqldatabase"
  server_id      = azurerm_mssql_server.sqlserver.id

}
