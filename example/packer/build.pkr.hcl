# ===================================================================
#  EXAMPLE
# ===================================================================

build {
  sources = ["source.azure-arm.ubuntu"]

  provisioner "shell" {
    name             = "demo"
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline           = [
      "echo \"Hello, Azure\"!",
      "cat /etc/issue.net",
    ]
  }
}
