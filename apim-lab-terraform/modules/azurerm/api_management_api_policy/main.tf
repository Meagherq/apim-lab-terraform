resource "azurerm_api_management_api_policy" "policy" {
  api_name            = var.api_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
 
  xml_content       = templatefile("../../modules/policy_content/api/${var.policy_filename}.tftpl", var.vars)
}