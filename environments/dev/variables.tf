variable "az_location" {
    description = "The Azure region to deploy to"
    type = string
    default = "eastus"
}

variable "environment" {
    description = "The environment type"
    type = string
}
