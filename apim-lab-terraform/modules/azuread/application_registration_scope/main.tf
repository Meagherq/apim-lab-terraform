resource "random_uuid" "scope_id" {}

resource "azuread_application_oauth2_permission_scope" "scope" {
  application_object_id      = var.application_registration_id
  admin_consent_description  = var.admin_consent_description
  admin_consent_display_name = var.admin_consent_display_name
  enabled                    = true
  type                       = var.type
  user_consent_description   = var.user_consent_description
  user_consent_display_name  = var.user_consent_display_name
  value                      = var.value
}