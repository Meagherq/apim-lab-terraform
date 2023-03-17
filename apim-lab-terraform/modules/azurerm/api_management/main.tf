resource "azurerm_api_management" "apim" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email

  sku_name = var.sku_name

  dynamic "additional_location" {
    for_each = var.scale_locations

    content {
      location = additional_location.key
      capacity = additional_location.value
    }
  }

  virtual_network_type = var.virtual_network_type

  dynamic "virtual_network_configuration" {
    for_each = var.subnet_id == null ? [] : toset([var.subnet_id])
    
    content {
      subnet_id = var.subnet_id
    }
  }

  identity {
    type = "SystemAssigned"
  }
}