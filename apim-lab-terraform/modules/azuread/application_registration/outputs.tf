output "primary_secret" {
    value = azuread_application_password.password.value
}

output "app_id" {
    value = azuread_application.appreg.application_id
}

output "id" {
    value = azuread_application.appreg.id
}

output "identifiers" {
    value = azuread_application.appreg.identifier_uris
}