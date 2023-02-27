resource "azurerm_api_management_api" "api" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  api_management_name   = var.api_management_name
  version               = var.version
  version_set_id        = var.version_set_id
  revision              = var.revision
  display_name          = var.display_name
  path                  = var.path
  service_url           = var.service_url
  protocols             = var.protocols
  description           = var.description
  subscription_required = var.subscription_required

  dynamic "import" {
    for_each = var.content_value == null ? {} : toset(var.content_value)

    content {
        content_format = var.content_format
        content_value = var.content_value
    }
  }
}