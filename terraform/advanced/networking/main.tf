# --- networking/main.tf ---

resource "openstack_networking_network_v2" "network" {
  name           = "${var.project}-network"
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "subnet" {
  count      = var.subnet_cidrs_count
  name       = "${var.project}-subnet-${count.index + 1}"
  network_id = openstack_networking_network_v2.network.id
  cidr       = var.subnet_cidrs[count.index]
  ip_version = 4
}

resource "openstack_networking_router_v2" "router" {
  name                = "${var.project}-router"
  admin_state_up      = true
  enable_snat         = true
  external_network_id = var.external_network_id
}

resource "openstack_networking_secgroup_v2" "router_sec_group" {
  name                 = "${var.project}-router_sec_group"
  delete_default_rules = true
}

resource "openstack_networking_secgroup_rule_v2" "router_sec_group_rule_in" {
  count             = var.subnet_cidrs_count
  description       = "Allow ALL from ${openstack_networking_subnet_v2.subnet[count.index].cidr}"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = openstack_networking_subnet_v2.subnet[count.index].cidr
  security_group_id = openstack_networking_secgroup_v2.router_sec_group.id
}

resource "openstack_networking_port_v2" "router_port_internal" {
  count          = var.subnet_cidrs_count
  name           = "${var.project}-router_port_internal-${count.index + 1}"
  admin_state_up = true
  network_id     = openstack_networking_network_v2.network.id
  allowed_address_pairs {
    ip_address = "0.0.0.0"
  }
  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet[count.index].id
    ip_address = join(".", [regex("^\\d+\\.\\d+\\.\\d+", openstack_networking_subnet_v2.subnet[count.index].cidr), "1"])
  }
  security_group_ids = [
    openstack_networking_secgroup_v2.router_sec_group.id
  ]
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  count     = var.subnet_cidrs_count
  router_id = openstack_networking_router_v2.router.id
  port_id   = openstack_networking_port_v2.router_port_internal[count.index].id
}
