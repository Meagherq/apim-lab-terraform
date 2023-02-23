output "primary_secret" {
    value = azuread_application_password.password.value
}