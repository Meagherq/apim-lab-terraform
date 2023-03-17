resource "azurerm_api_management_subscription" "subscription" {
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  user_id             = var.user_id
  api_id              = var.api_id
  product_id          = var.product_id
  display_name        = var.display_name
}