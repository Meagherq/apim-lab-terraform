locals {
  final_log_category_types = setsubtract(data.azurerm_monitor_diagnostic_categories.categories.log_category_types, var.excluded_category_types)
}

data "azurerm_monitor_diagnostic_categories" "categories" {
  resource_id = var.resource_id
}

resource "azurerm_monitor_diagnostic_setting" "setting" {
  name                           = var.name
  target_resource_id             = var.resource_id
  storage_account_id             = var.storage_account_id
  eventhub_name                  = var.eventhub_name
  log_analytics_destination_type = var.log_analytics_destination_type
  log_analytics_workspace_id     = var.log_analytics_workspace_id


  dynamic "enabled_log" {
    for_each = local.final_log_category_types

    content {
      category = enabled_log.value
      
      dynamic "retention_policy" {
        for_each = var.storage_account_id == null ? {} : toset(var.storage_account_id)
        content {
          enabled = true
          days = var.storage_retention_days
        }
        
      }
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.categories.metrics

    content {
      category = enabled_log.value
      
      dynamic "retention_policy" {
        for_each = var.storage_account_id == null ? {} : toset(var.storage_account_id)
        content {
          enabled = true
          days = var.storage_retention_days
        }
        
      }
    }
  }
}