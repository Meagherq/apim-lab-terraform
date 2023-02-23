data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "policy" {
  key_vault_id = var.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.object_id

  key_permissions = var.key_permissions
  secret_permissions = var.secret_permissions
}