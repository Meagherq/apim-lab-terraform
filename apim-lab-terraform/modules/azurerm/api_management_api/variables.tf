variable name {}
variable resource_group_name {}
variable api_management_name {}
variable versionNumber {
    default = null
}
variable version_set_id {
    default = null
}
variable revision {
    default = 1
}
variable display_name {
    default = null
}
variable service_url {
    default = null
}
variable path {
    default = null
}
variable protocols {
    default = null
}
variable description {
    default = null
}
variable subscription_required {
    default = false
}
variable content_format {
    default = null
}
variable content_value {
    default = null
}
variable source_api_id {
    default = null
}
variable authorization_server_name {
    default = null
}

variable tf_client_id {
    default = null
}

variable tf_client_secret {
    default = null
}

variable subscription_id {
    default = null
}
variable "api_type" {
    default = "http"
}