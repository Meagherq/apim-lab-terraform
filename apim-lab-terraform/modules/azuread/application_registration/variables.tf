variable "display_name" {}
variable "app_identifier" {}
variable "redirect_uris" {
    default = []
}
variable "resource_app_id" {
    default = null
}
variable "permission_id" {
    default = null
}
variable "signInAudiance" {
    default = "AzureADMultipleOrgs"
}
variable "permissions" {
    default = {}
}