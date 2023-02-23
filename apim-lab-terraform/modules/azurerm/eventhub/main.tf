resource "azurerm_eventhub" "hub" {
  name                = var.name
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
  partition_count     = var.partition_count
  message_retention   = var.message_retention
}