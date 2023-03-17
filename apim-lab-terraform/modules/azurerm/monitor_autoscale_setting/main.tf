resource "azurerm_monitor_autoscale_setting" "setting" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = var.resource_id

  profile {
    name = "defaultProfile"

    capacity {
      default = 1
      minimum = 1
      maximum = var.maximum_capacity
    }

    rule {
      metric_trigger {
        metric_name        = var.metric_name
        metric_resource_id = var.resource_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = var.scale_up_threshold
        metric_namespace   = var.metric_namespace
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = [var.name]
        }
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = var.metric_name
        metric_resource_id = var.resource_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = var.scale_down_threshold
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

  notification {
    email {
      send_to_subscription_administrator    = true
      send_to_subscription_co_administrator = true
      custom_emails                         = [var.admin_email]
    }
  }
}