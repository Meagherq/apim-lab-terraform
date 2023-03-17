variable resource_id {}
variable name {}
variable storage_account_id {
    default = null
}
variable eventhub_name {
    default = null
}
variable eventhub_authorization_rule_id {
    default = null
}
variable log_analytics_destination_type {
    default = "Dedicated"
}
variable log_analytics_workspace_id {
    default = null
}
variable storage_retention_days {
    defaut = 90
}