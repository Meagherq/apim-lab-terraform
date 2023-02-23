resource "azurerm_api_management_authorization_server" "server" {
  name                         = var.name
  api_management_name          = var.api_management_name
  resource_group_name          = var.resource_group_name
  display_name                 = var.display_name
  authorization_endpoint       = var.authorization_endpoint
  client_id                    = var.client_id
  client_registration_endpoint = var.client_registration_endpoint

  grant_types = var.grant_types
  authorization_methods = var.authorization_methods
}