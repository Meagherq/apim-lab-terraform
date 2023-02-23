output "name" {
    value = azurerm_api_management.apim.name
}

output "id" {
    value = azurerm_api_management.apim.id
}

output "principal_identity" {
    value = azurerm_api_management.apim.identity.0.principal_identity
}