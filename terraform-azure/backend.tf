terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-test"
    storage_account_name = "stterraform676436e2"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}