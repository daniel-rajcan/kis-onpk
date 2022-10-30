# --- compute/main.tf ---

resource "openstack_networking_secgroup_v2" "security_group" {
  name        = "${var.project}-${var.environment}-secgroup"
  description = "Managed by Terraform!"
}

# Allow ICMP from University network
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_university_icmp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = local.university.network.cidr
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

# Allow UDP from University network
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_university_udp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  remote_ip_prefix  = local.university.network.cidr
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

# Allow TCP from University network
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_university_tcp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = local.university.network.cidr
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

# Allow ICMP from your public IP address
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_icmp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = join("/", [var.my_public_ip, "32"])
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

# Allow UDP from your public IP address
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_udp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  remote_ip_prefix  = join("/", [var.my_public_ip, "32"])
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

# Allow ALL TCP from your public IP address
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_tcp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = join("/", [var.my_public_ip, "32"])
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

data "openstack_images_image_v2" "flavor_id" {
  name        = var.flavor_name
  most_recent = true
}

# Create Virtual Machine
resource "openstack_compute_instance_v2" "instance" {
  name            = "${var.project}-${var.environment}-instance"
  image_id        = local.image.ubuntu.id
  flavor_id       = data.openstack_images_image_ids_v2.flavor_id.id
  key_pair        = var.key_pair_name
  security_groups = [openstack_networking_secgroup_v2.security_group.name]

  user_data = var.user_data

  network {
    name = var.network_name
  }
}
