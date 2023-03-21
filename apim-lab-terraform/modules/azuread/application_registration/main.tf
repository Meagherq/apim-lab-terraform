data "azuread_client_config" "current" {}

resource "azuread_application" "appreg" {
  display_name     = var.display_name
  identifier_uris  = ["api://${var.app_identifier}"]
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = var.signInAudiance

  api {
    mapped_claims_enabled          = true
    requested_access_token_version = 2

    dynamic "oauth2_permission_scope" {
      for_each = var.permissions
      content {
        id = oauth2_permission_scope.value["id"]
        admin_consent_description = oauth2_permission_scope.value["admin_consent_description"]
        admin_consent_display_name = oauth2_permission_scope.value["admin_consent_display_name"]
        user_consent_description = oauth2_permission_scope.value["user_consent_description"]
        user_consent_display_name = oauth2_permission_scope.value["user_consent_display_name"]
        value = oauth2_permission_scope.key
      }
      
    }
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }

    resource_access {
      id   = "37f7f235-527c-4136-accd-4a02d197296e" # openid
      type = "Scope"
    }

    resource_access {
      id   = "14dad69e-099b-42c9-810b-d002981feec1" # profile
      type = "Scope"
    }

    resource_access {
      id = "7427e0e9-2fba-42fe-b0c0-848c9e6a8182" # offline_access
      type = "Scope"
    }
  }

  dynamic "required_resource_access" {
    for_each = var.resource_app_id == null ? [] : toset([var.resource_app_id])

    content {
        resource_app_id = var.resource_app_id
        resource_access {
          id = var.permission_id
          type = "Scope"
        }
    }
  }

  feature_tags {
    enterprise = true
    gallery    = true
  }

  web {
    redirect_uris = var.redirect_uris

    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }
}

resource "azuread_application_password" "password" {
  application_object_id = azuread_application.appreg.object_id
}

resource "azuread_service_principal" "sp" {
  application_id               = azuread_application.appreg.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}