# ===============================================
#  MODULE INPUT VARIABLES
# ===============================================

variable required {
  description = "(Required) Configure this module. See values defined in 'local.defaults' for more info."
  type = object(
    {
      build_id = string
    }
  )
}

variable optional {
  description = "(Optional) Customize this module. See values defined in 'local.defaults' for more info."
  default     = null
}

# ===============================================
#  MODULE CONFIGURATION VARIABLES
# ===============================================

locals {
  config   = merge(local.defaults, var.optional, var.required)
  
  defaults = {
    # Required variables (will be overwritten)
    build_id = "<REQUIRED>"

    # Optional variables; can be overwritten by use of 'optional' variable
    interpreter = ["/usr/bin/env", "bash", "-c"]
    environment = {}
    working_dir = "${path.root}/packer"
    command     = "packer build ."
  }
}
