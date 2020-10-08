terraform {
  required_version = "~> 0.13.0"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.30.0"}
  }
}

provider azurerm {
  subscription_id         = var.azure.subscription_id
  tenant_id               = var.azure.tenant_id
  client_id               = var.azure.client_id
  client_certificate_path = "${path.cwd}/../.credentials/azure-packer.pfx"
  features {}
}

provider null {}