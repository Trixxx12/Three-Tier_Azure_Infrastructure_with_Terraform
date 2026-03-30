terraform {
    backend "azurerm"{
        use_cli = true
        use_azuread_auth = true
        tenant_id = "2b5476f7-8910-4ed8-abe6-8136bf049ab4"
        storage_account_name = "tfstateblb2001"
        container_name = "tfstate"
        key = "dev.terraform.tfstate"
    }
}