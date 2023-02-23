resource "azurerm_api_management_policy" "policy" {
  api_management_id = var.api_management_id
  xml_content       = templatefile(file("../../policy_content/global/${var.policy_filename}.tftpl"), var.vars)
}