# --- root/variables.tf ---

variable "openstack_username" {
  type = string
}

variable "openstack_password" {
  type = string
}

variable "openstack_auth_url" {
  type    = string
  default = "http://10.0.0.25/identity"
}

variable "openstack_region" {
  type    = string
  default = "RegionOne"
}

variable "environment" {
  type = map(any)
  default = {
    dev = {
      tenant_name    = "admin"
      instance_count = 1
    }

    prod = {
      tenant_name    = "demo"
      instance_count = 2
    }
  }
}

variable "internal_network_cidr" {
  type    = string
  default = "10.255.0.0/16"
}
