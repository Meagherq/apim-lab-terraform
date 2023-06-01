resource "azurerm_api_management_api_operation_policy" "policy" {
  for_each = var.policies

  api_name            = var.api_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  operation_id        = each.value.OperationId


  xml_content       = base64decode(each.value.Policy)
}