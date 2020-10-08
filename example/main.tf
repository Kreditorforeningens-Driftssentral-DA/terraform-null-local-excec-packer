/*
=================================================

  Create a 'terrapack' image with Azure-builder

  Note:
    Variables/locals, data-sources and outputs
    are included in this file for easier
    readability. It should be split into
    separate files

  Tip:
    It looks cleaner to not provide the
    module-variables inline, like it is done
    in this example. See below:

    module some_module_name {
      source   = "<module-source-url>"
      version  = "<module-version>"
      required = local.packer_required_variables
      optional = local.packer_optional_variables
    }

=================================================
*/

variable azure {}

locals {
  packer_image_name = join("-", ["packer-demo", formatdate("YYYYMMDDhhmmss", timestamp())])
}

# Create Azure resource group
resource azurerm_resource_group "PACKER" {
  name     = var.azure.resource_group_name
  location = var.azure.resource_group_location
}

# Build an Azure-ARM packer image
module packer_example {
  source   = "../." # You should use registry url w/pinned version
  required = {
    build_id = local.packer_image_name # If this value changes, a new build is triggered
  }
  optional = {
    environment = {
      PKR_VAR_subscription_id         = var.azure.subscription_id
      PKR_VAR_tenant_id               = var.azure.tenant_id
      PKR_VAR_object_id               = var.azure.object_id
      PKR_VAR_client_id               = var.azure.client_id
      PKR_VAR_client_cert_path        = "${path.cwd}/../.credentials/azure-packer.pem"
      PKR_VAR_resource_group_name     = azurerm_resource_group.PACKER.name
      PKR_VAR_resource_group_location = azurerm_resource_group.PACKER.location
      PKR_VAR_packer_image_name       = local.packer_image_name
    }
  }
}

# Lookup the created image
data azurerm_image "PACKER_LATEST" {
  depends_on          = [module.packer_example]
  resource_group_name = azurerm_resource_group.PACKER.name
  name                = local.packer_image_name
}

# Printout created image id
output image_id {
  value = data.azurerm_image.PACKER_LATEST.id
}
