variable azure {}

locals {
  packer_image_name = join("-", ["packer-demo", formatdate("YYYYMMDDhhmmss", timestamp())])
}

# Create Azure resource group
resource azurerm_resource_group "PACKER" {
  name     = var.azure.resource_group_name
  location = var.azure.resource_group_location
}

# Build Azure-ARM packer image
module packer_example {
  source     = "../." # You should use registry url
  #version = "v0.1.0" # You should use pinned version
  #depends_on = [azurerm_resource_group.PACKER]
  # --
  required = { build_id = local.packer_image_name }
  optional = {
    environment = {
      # Azure Authentication
      PKR_VAR_subscription_id  = var.azure.subscription_id
      PKR_VAR_tenant_id        = var.azure.tenant_id
      PKR_VAR_object_id        = var.azure.object_id
      PKR_VAR_client_id        = var.azure.client_id
      PKR_VAR_client_cert_path = "${path.cwd}/../.credentials/azure-packer.pem"

      # Azure Existing Resources
      PKR_VAR_resource_group_name     = azurerm_resource_group.PACKER.name
      PKR_VAR_resource_group_location = azurerm_resource_group.PACKER.location
      
      # Other
      PKR_VAR_packer_image_name = local.packer_image_name
    }
  }
}
