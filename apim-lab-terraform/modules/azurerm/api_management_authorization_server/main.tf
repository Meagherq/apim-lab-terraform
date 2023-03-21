resource "azurerm_api_management_authorization_server" "server" {
  name                         = var.name
  api_management_name          = var.api_management_name
  resource_group_name          = var.resource_group_name
  display_name                 = var.display_name
  authorization_endpoint       = var.authorization_endpoint
  token_endpoint               = var.token_endpoint
  client_id                    = var.client_id
  client_secret                = var.client_secret
  client_registration_endpoint = var.client_registration_endpoint
  default_scope = var.default_scope

  grant_types = var.grant_types
  authorization_methods = var.authorization_methods
  bearer_token_sending_methods = var.bearer_token_sending_methods
  client_authentication_method = var.client_authentication_method
}