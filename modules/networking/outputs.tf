output "web_subnet_id" {
    value = azurerm_subnet.rg_web.id
}
output "app_subnet_id" {
    value = azurerm_subnet.rg_app.id
}
output "database_subnet_id" {
    value = azurerm_subnet.rg_database.id
}
output "management_subnet_id" {
    value = azurerm_subnet.rg_management.id
}
