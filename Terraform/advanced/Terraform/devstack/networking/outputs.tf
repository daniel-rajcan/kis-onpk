# --- networking/outputs.tf ---

output "ext_network" {
  value = {
    id : var.external_network_id
    name : "public"
  }
}

output "int_network" {
  value = {
    id : openstack_networking_network_v2.network.id
    name : openstack_networking_network_v2.network.name
  }
}

output "int_subnets" {
  value = {
    id : openstack_networking_subnet_v2.subnet[*].id
    name : openstack_networking_subnet_v2.subnet[*].name
  }
}

output "int_subnet_ids" {
  value = openstack_networking_subnet_v2.subnet[*].id
}

output "router" {
  value = {
    id : openstack_networking_router_v2.router.id
    name : openstack_networking_router_v2.router.name
  }
}

output "router_int_ports" {
  value = {
    id : openstack_networking_port_v2.router_port_internal[*].id
    name : openstack_networking_port_v2.router_port_internal[*].name
  }
}

output "router_sec_group" {
  value = {
    id : openstack_networking_secgroup_v2.router_sec_group.id
    name : openstack_networking_secgroup_v2.router_sec_group.name
  }
}
