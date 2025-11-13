terraform {
  backend "azurerm" {
    resource_group_name   = "rg-terraform-test"
    storage_account_name  = "stterraform676436e2"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
    subscription_id       = "b3b74f5d-6623-4043-8d82-24bc7f981535"
  }
}