resource "azurerm_api_management_api_operation" "op" {
  operation_id        = var.operation_id
  api_name            = var.api_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  display_name        = var.display_name
  method              = var.method
  url_template        = var.url_template
  description         = var.description

  dynamic "template_parameter" {
    for_each = var.template_parameters

    content {
      name = template_parameter.key
      required = template_parameter.value["required"]
      type = template_parameter.value["type"]
    }
  }

  response {
    status_code = var.status_code
  }

  dynamic "response" {
    for_each = var.mocked_responses

    content {
      status_code = response.key

      description = response.value["description"]
      representation {
        content_type = "application/json"

        example {
          name = response.value["name"]
          value = response.value["value"]
        }
      }
    }
  }
}