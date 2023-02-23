resource "azurerm_api_management_product_api" "example" {
  api_name            = var.api_name
  product_id          = var.product_id
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
}