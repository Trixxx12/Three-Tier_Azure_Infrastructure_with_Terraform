resource "azurerm_resource_group" "rg_main" {
  name     = "rg-main"
  location = var.az_location
}

# VM Resource
resource "azurerm_virtual_network" "rg_vnet" {
  name                = "rg-vnet"
  location            = azurerm_resource_group.rg_main.location
  resource_group_name = azurerm_resource_group.rg_main.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = var.environment
  }
}

# VM Subnets
resource "azurerm_subnet" "rg_web" {
  name                 = "vnet-web"
  virtual_network_name = azurerm_virtual_network.rg_vnet.name
  resource_group_name  = azurerm_resource_group.rg_main.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_subnet" "rg_app" {
  name                 = "vnet-app"
  virtual_network_name = azurerm_virtual_network.rg_vnet.name
  resource_group_name  = azurerm_resource_group.rg_main.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_subnet" "rg_database" {
  name                 = "vnet-database"
  virtual_network_name = azurerm_virtual_network.rg_vnet.name
  resource_group_name  = azurerm_resource_group.rg_main.name
  address_prefixes     = ["10.0.3.0/24"]
}
resource "azurerm_subnet" "rg_management" {
  name                 = "vnet-management"
  virtual_network_name = azurerm_virtual_network.rg_vnet.name
  resource_group_name  = azurerm_resource_group.rg_main.name
  address_prefixes     = ["10.0.4.0/24"]
}

# NSGs
resource "azurerm_network_security_group" "rg_web_nsg" {
  name                = "web-nsg"
  location            = var.az_location
  resource_group_name = azurerm_resource_group.rg_main.name

  security_rule {
    name                       = "web"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"]
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "10.0.1.0/24"
  }
}

resource "azurerm_network_security_group" "rg_app_nsg" {
  name                = "app-nsg"
  location            = var.az_location
  resource_group_name = azurerm_resource_group.rg_main.name

  security_rule {
    name                       = "app"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "10.0.2.0/24"
  }
}

resource "azurerm_network_security_group" "rg_database_nsg" {
  name                = "database-nsg"
  location            = var.az_location
  resource_group_name = azurerm_resource_group.rg_main.name

  security_rule {
    name                       = "database"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "10.0.2.0/24"
    destination_address_prefix = "10.0.3.0/24"
  }
}

resource "azurerm_network_security_group" "rg_management_nsg" {
  name                = "management-nsg"
  location            = var.az_location
  resource_group_name = azurerm_resource_group.rg_main.name

  security_rule {
    name                       = "management"
    priority                   = 250
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "10.0.4.0/24"
  }
}

# NSG Association
resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id                 = azurerm_subnet.rg_web.id
  network_security_group_id = azurerm_network_security_group.rg_web_nsg.id
}
resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.rg_app.id
  network_security_group_id = azurerm_network_security_group.rg_app_nsg.id
}
resource "azurerm_subnet_network_security_group_association" "database" {
  subnet_id                 = azurerm_subnet.rg_database.id
  network_security_group_id = azurerm_network_security_group.rg_database_nsg.id
}
resource "azurerm_subnet_network_security_group_association" "management" {
  subnet_id                 = azurerm_subnet.rg_management.id
  network_security_group_id = azurerm_network_security_group.rg_management_nsg.id
}
