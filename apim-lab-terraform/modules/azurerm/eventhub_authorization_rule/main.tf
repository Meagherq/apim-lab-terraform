resource "azurerm_eventhub_authorization_rule" "rule" {
  name                = var.name
  namespace_name      = var.eventhub_namespace_name
  eventhub_name       = var.eventhub_name
  resource_group_name = var.resource_group_name
  listen              = var.listen
  send                = var.send
  manage              = var.manage
}