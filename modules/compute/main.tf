resource "azurerm_network_interface" "web_nic1" {
    name = "web-nic1"
    location = var.az_location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name = "internal"
        subnet_id = var.web_subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_network_interface" "web_nic2" {
    name = "web-nic2"
    location = var.az_location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name = "internal"
        subnet_id = var.web_subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_network_interface" "app_nic1" {
    name = "app-nic1"
    location = var.az_location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name = "internal"
        subnet_id = var.app_subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_network_interface" "app_nic2" {
    name = "app-nic2"
    location = var.az_location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name = "internal"
        subnet_id = var.app_subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_network_interface" "mgmt_nic" {
    name = "mgmt-nic"
    location = var.az_location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name = "internal"
        subnet_id = var.jb_subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}