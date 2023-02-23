resource "azurerm_api_management_api_operation_policy" "policy" {
  api_name            = var.api_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  operation_id        = var.operation_id

  xml_content = templatefile(file("../../policy_content/operation/${var.policy_filename}.tftpl"), var.vars)
}