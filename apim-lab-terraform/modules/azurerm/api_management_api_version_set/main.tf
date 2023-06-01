resource "azurerm_api_management_api_version_set" "set" {
  name                = var.name
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name
  display_name        = var.display_name
  versioning_scheme   = var.versioning_scheme
}