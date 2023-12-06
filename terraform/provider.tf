provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"

    }


  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "personal"
    storage_account_name = "nobleone"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}