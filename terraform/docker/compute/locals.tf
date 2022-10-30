# --- compute/locals.tf ---

locals {
  image = {
    ubuntu = {
      id          = "0fc1152a-4037-4d89-a22a-60f477e2eba0"
      os_username = "ubuntu"
    }
  }

  university = {
    network = {
      cidr = "158.193.0.0/16"
    }
  }
}
