# TERRAFORM NULL MODULE ([local-excec-packer](https://registry.terraform.io/modules/Kreditorforeningens-Driftssentral-DA/local-excec-packer/null/0.1.0))

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/Kreditorforeningens-Driftssentral-DA/terraform-null-local-excec-packer)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/Kreditorforeningens-Driftssentral-DA/terraform-null-local-excec-packer)
![GitHub issues](https://img.shields.io/github/issues/Kreditorforeningens-Driftssentral-DA/terraform-null-local-excec-packer)

## DESCRIPTION

This is a very basic module for running packer via terraform (lets call it 'TerraPacking').
* Everything here can just as easily be ran directly via the null_resource instead of using the module,
but I find it 'cleaner' to use a module. A new packer-build will be triggered when the variable
'required.build_id' changes.
* The module passes inputs directly to corresponding 'null_resource' fields, but sets some defaults.
* Providing dynamic user-variables to packer can be done by e.g. sending PKR_VAR_<variable> via
the module variable 'optional.environment'.

See the example-folder for full/working example(s).

#### REQUIREMENTS

* Packer installed & in path for the 'command' (since it runs locally)
* Packer files in an available directory, passed via 'command' or by settings working_dir (defaults to ./packer)

## USING THIS MODULE

See the example-folder for full/working example(s).

```bash
#... other terraform resources.. See example-dir

# Build Azure-ARM packer image
module packer_example {
  source  = "https://registry.terraform.io/modules/Kreditorforeningens-Driftssentral-DA/local-excec-packer/null/0.1.0"
  version = "v0.1.0" # You should always pin version
  depends_on = [azurerm_resource_group.EXAMPLE]
  # --
  required = {
    build_id = "some-build-id" # If this changes, a new build is triggered
  }
  optional = {
    environment = {
      # Passing variables to packer (azure-arm-builder)

      # Authentication
      PKR_VAR_subscription_id  = "<azure-subscription-id>"
      PKR_VAR_tenant_id        = "<azure-tenant-id>"
      PKR_VAR_object_id        = "<azure-object-id>"
      PKR_VAR_client_id        = "<azure-client-id>"
      PKR_VAR_client_cert_path = "<azure-client-certificate-path>.pem" # Relative to packer working_dir

      # Referencing pre-created Azure Resources
      PKR_VAR_resource_group_name     = azurerm_resource_group.EXAMPLE.name
      PKR_VAR_resource_group_location = azurerm_resource_group.EXAMPLE.location

      # Other Settings
      PKR_VAR_packer_image_name       = "packer-demo-image"
    }
  }
}
```
