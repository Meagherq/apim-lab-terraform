output "connection_string" {
    value = azurerm_eventhub_authorization_rule.rule.primary_connection_string
}