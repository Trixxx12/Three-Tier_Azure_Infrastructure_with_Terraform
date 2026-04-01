variable "az_location" {
    description = "The Azure region to deploy to"
    type = string
    default = "eastus"
}

variable "environment" {
    description = "The environment type"
    type = string
}

variable "web_subnet_id" {
    description = "Web tier subnet ID"
    type = string
}

variable "app_subnet_id" {
    description = "App tier subnet ID"
    type = string
}

variable "db_subnet_id" {
    description = "Database tier subnet ID"
    type = string
}

variable "jb_subnet_id" {
    description = "Jump box subnet ID"
    type = string
}

variable "resource_group_name" {
    description = "Resource group name"
    type = string
}

