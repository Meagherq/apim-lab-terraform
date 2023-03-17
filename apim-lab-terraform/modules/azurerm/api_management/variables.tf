variable name {}
variable location {}
variable resource_group_name {}
variable publisher_name {}
variable publisher_email {}
variable "sku_name" {
    default = "Developer_1"
}
variable "scale_locations" {
    default = {}
}
variable "virtual_network_type" {
    default = "None"
}
variable "subnet_id" {
    default = null
}