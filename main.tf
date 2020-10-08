resource null_resource "PACKER" {

  # https://www.packer.io/docs/from-1.5/variables#environment-variables
  provisioner local-exec {
    working_dir = local.config.working_dir
    interpreter = local.config.interpreter
    command     = local.config.command
    environment = local.config.environment
  }

  # Re-run if defined id changes
  triggers = {
    id = local.config.build_id
  }
}
