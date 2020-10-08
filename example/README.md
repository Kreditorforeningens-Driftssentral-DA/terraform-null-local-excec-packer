# MODULE EXAMPLE

This example shows how to build and store a simple packer image with azure-arm

#### GENERAL INFO

* 'required.build_id' is set using a timestamp, meaning every run will force a new image
* The terraform azure-provider requires pfx-formatted certificate, but the packer azure-builder
uses pem-format. You can use openssl or some other tool to create the pfx from a pem

#### RUNNING THIS EXAMPLE

```bash
# Fill in required values for the variables you use
# in a .tfvars-file (e.g. workspace.tfvars used here)
# or similar method (local-vars, etc).
# You can use the 'example.tfvars' as a basis for the
# provided packer-example.

# Initialize workspace
$ terraform init

# Check configuration
$ terraform plan -var-file='workspace.tfvars'

# Create resources
$ terraform apply -var-file='workspace.tfvars' -auto-approve

# Destroy resources
$ terraform destroy -auto-approve
```
