resource "azurerm_api_management_logger" "logger" {
  name                = var.name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  resource_id         = var.resource_id


  dynamic "application_insights" {
    for_each = var.application_insights_instrumentation_key == null ? [] : toset([var.application_insights_instrumentation_key])

    content {
        instrumentation_key = var.application_insights_instrumentation_key
    }
  }

  dynamic "eventhub" {
    for_each = var.eventhub_name == null ? [] : toset([var.eventhub_name])

    content {
        name = var.eventhub_name
        connection_string = var.eventhub_connection_string
    }
  }
}