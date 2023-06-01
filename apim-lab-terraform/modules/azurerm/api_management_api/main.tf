data "azuread_client_config" "current" {}

resource "azurerm_api_management_api" "api" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  api_management_name   = var.api_management_name
  version               = var.versionNumber
  version_set_id        = var.version_set_id
  revision              = var.revision
  display_name          = var.display_name
  path                  = var.path
  api_type              = var.api_type
  service_url           = var.service_url
  protocols             = var.protocols
  description           = var.description
  subscription_required = var.subscription_required
  source_api_id         = var.source_api_id

  dynamic "import" {
    for_each = var.content_value == null ? [] : toset([var.content_value])

    content {
      content_format = var.content_format
      content_value  = var.content_value

      dynamic "wsdl_selector" {
        for_each = var.content_format == "wsdl" ? toset([var.content_format]) : []

        content {
          service_name = "ServiceName"
          endpoint_name  = "EndpointName"
        }
      }
    }
  }

  dynamic "oauth2_authorization" {
    for_each = var.authorization_server_name == null ? [] : toset([var.authorization_server_name])

    content {
      authorization_server_name = var.authorization_server_name
    }
  }

  # provisioner "local-exec" {
  #   when = create
  #   command = "${path.module}/processWSDLApiOperations3.ps1 -clientId ${var.tf_client_id} -clientSecret ${var.tf_client_secret} -tenantId ${data.azuread_client_config.current.tenant_id} -subscriptionId ${var.subscription_id} -resourceGroupName ${self.resource_group_name} -apimName ${self.api_management_name} -apiId ${self.name}"
  #   interpreter = ["PowerShell", "-Command"]
  # }
}

# data "external" "wsdl_operations" {
#   for_each = var.content_format == "wsdl" ? toset([var.content_format]) : []

#   program = [
#     "PowerShell",
#     "${path.module}/processWSDLApiOperations.ps1",
#   ]

#   query = {
#     clientId = var.tf_client_id
#     clientSecret = var.tf_client_secret
#     tenantId = data.azuread_client_config.current.tenant_id
#     subscriptionId = var.subscription_id
#     resourceGroupName = azurerm_api_management_api.api.resource_group_name
#     apimName = azurerm_api_management_api.api.api_management_name
#     apiId = azurerm_api_management_api.api.name
#   }

#   depends_on = [ azurerm_api_management_api.api ]
# }



