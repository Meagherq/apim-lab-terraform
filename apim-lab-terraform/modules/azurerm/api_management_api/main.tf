resource "azurerm_api_management_api" "api" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  api_management_name   = var.api_management_name
  version               = var.versionNumber
  version_set_id        = var.version_set_id
  revision              = var.revision
  display_name          = var.display_name
  path                  = var.path
  service_url           = var.service_url
  protocols             = var.protocols
  description           = var.description
  subscription_required = var.subscription_required
  source_api_id         = var.source_api_id

  dynamic "import" {
    for_each = var.content_value == null ? [] : toset([var.content_value])

    content {
        content_format = var.content_format
        content_value = var.content_value
    }
  }

  dynamic "oauth2_authorization" {
    for_each = var.authorization_server_name == null ? [] : toset([var.authorization_server_name])

    content {
      authorization_server_name = var.authorization_server_name
    }
  }
}