resource "azurerm_api_management_product" "product" {
  product_id            = var.product_id
  api_management_name   = var.api_management_name
  resource_group_name   = var.resource_group_name
  display_name          = var.display_name
  subscription_required = var.subscription_required
  approval_required     = var.approval_required
  published             = var.published
}