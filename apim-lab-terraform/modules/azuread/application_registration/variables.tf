variable "display_name" {}
variable "app_identifier" {}
variable "redirect_uris" {}
variable "resource_app_id" {}
variable "parmission_id" {}
variable "signInAudiance" {
    default = "AzureADMultipleOrgs"
}