# ===================================================================
#  EXAMPLE
# ===================================================================

source "azure-arm" "ubuntu" {

  # Azure Authentication
  subscription_id  = var.subscription_id
  tenant_id        = var.tenant_id
  object_id        = var.object_id
  client_id        = var.client_id
  client_cert_path = var.client_cert_path

  # Builder VM settings
  location                          = var.resource_group_location
  managed_image_resource_group_name = var.resource_group_name
  managed_image_name                = var.packer_image_name
  temp_resource_group_name          = "TerraPackBuild-${var.packer_image_name}"

  vm_size         = "Standard_B1ls"
  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "UbuntuServer"
  image_sku       = "18.04-LTS"
  image_version   = "latest"

  azure_tags = {
    builder = "terrapack"
    role    = "server"
  }
}
