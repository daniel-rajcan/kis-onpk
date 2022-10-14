# --- root/providers.tf ---

# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs
terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

provider "openstack" {
  user_name   = var.openstack_username
  password    = var.openstack_password
  tenant_name = local.deployment["tenant_name"]
  auth_url    = var.openstack_auth_url
  region      = var.openstack_region
}
