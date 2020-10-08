# MODULE EXAMPLE

This example shows how to build and store a simple packer image with azure-arm

#### GENERAL INFO

* 'required.build_id' is set using a timestamp, meaning every run will force a new image
* The terraform azure-provider requires pfx-formatted certificate, but the packer azure-builder
uses pem-format. You can use openssl or some other tool to create the pfx from a pem
