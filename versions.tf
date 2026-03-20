##-----------------------------------------------------------------------------
## Versions
##-----------------------------------------------------------------------------
# Terraform version
terraform {
  required_version = ">= 1.10.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.116.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }

  provider_meta "azurerm" {
    module_name = "terraform-az-modules/terraform-azurerm-flexible-postgresql"
  }
}
