# --- compute/outputs.tf ---

output "project_name" {
  value = var.project
}

output "instance_name" {
  value = openstack_compute_instance_v2.instance.name
}

output "instance_ipv4_address" {
  value = openstack_compute_instance_v2.instance.access_ip_v4
}
output "instance_ipv6_address" {
  value = openstack_compute_instance_v2.instance.access_ip_v6
}

output "instance_network_name" {
  value = var.network_name
}

output "instance_security_group_id" {
  value = openstack_networking_secgroup_v2.security_group.id
}

output "user_data_logs_path" {
  value = "/var/log/cloud-init-output.log"
}

output "ssh_command" {
  value = "ssh -i ${abspath(".")}/${var.key_pair_name}.pem ${local.image.ubuntu.os_username}@${openstack_compute_instance_v2.instance.access_ip_v4}"
}
