resource "azurerm_api_management_api_diagnostic" "diagnostic" {
  identifier               = var.identifier
  resource_group_name      = var.resource_group_name
  api_management_name      = var.api_management_name
  api_name                 = var.api_name
  api_management_logger_id = var.api_management_logger_id

  sampling_percentage       = var.sampling_percentage
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = var.verbosity
  http_correlation_protocol = var.http_correlation_protocol

  frontend_request {
    body_bytes = 0
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
    ]
  }

  frontend_response {
    body_bytes = 0
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
    ]
  }

  backend_request {
    body_bytes = 0
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
    ]
  }

  backend_response {
    body_bytes = 0
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
    ]
  }
}