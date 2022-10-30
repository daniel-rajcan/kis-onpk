# --- computing/main.tf ---

resource "random_string" "random" {
  count   = var.instance_count
  length  = 4
  special = false
  upper   = false
}

resource "openstack_networking_port_v2" "instance_port" {
  count          = var.instance_count
  name           = "${var.project}-instance_port-${random_string.random[count.index].result}"
  admin_state_up = true
  network_id     = var.network_id
  fixed_ip {
    subnet_id = var.subnet_ids[count.index]
  }
}

resource "openstack_compute_instance_v2" "instance" {
  count     = var.instance_count
  name      = "${var.project}-instance-${random_string.random[count.index].result}"
  image_id  = var.image_id
  flavor_id = "c1"
  network {
    port = openstack_networking_port_v2.instance_port[count.index].id
  }
}
