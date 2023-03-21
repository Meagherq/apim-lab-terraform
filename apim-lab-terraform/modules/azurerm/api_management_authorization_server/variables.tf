variable name {}
variable api_management_name {}
variable resource_group_name {}
variable display_name {}
variable authorization_endpoint {}
variable token_endpoint {}
variable client_id {}
variable client_secret {}
variable client_registration_endpoint {}
variable grant_types {
    default = ["authorizationCode"]
}
variable authorization_methods {
    default = ["GET", "POST"]
}
variable bearer_token_sending_methods {
    default = ["authorizationHeader"]
}
variable client_authentication_method {
    default = ["Body"]
}
variable default_scope {}