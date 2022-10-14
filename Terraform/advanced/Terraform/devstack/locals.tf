# --- root/locals.tf ---

locals {
  deployment = {
    tenant_name    = var.environment[terraform.workspace]["tenant_name"]
    instance_count = var.environment[terraform.workspace]["instance_count"]
  }
}
