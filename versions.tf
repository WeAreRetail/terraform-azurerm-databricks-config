terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.35.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.66.0"
    }

    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = ">= 1.2.25"
    }

    databricks = {
      source  = "databricks/databricks"
      version = ">= 1.21.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }
  }
}
