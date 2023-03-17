resource "azurerm_api_management_redis_cache" "cache" {
  name              = var.name
  api_management_id = var.api_management_id
  connection_string = var.connection_string
  description       = var.description
  redis_cache_id    = var.redis_cache_id
  cache_location    = var.cache_location
}