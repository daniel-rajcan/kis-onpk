# --- compute/locals.tf ---

locals {
  image = {
    ubuntu = {
      name        = "ubuntu_server_20.04_Openstack"
      os_username = "ubuntu"
    }
  }

  university = {
    network = {
      cidr = "158.193.0.0/16"
    }
  }
}
