# --- computing/outputs.tf ---

output "flavor" {
  value = {
    id : openstack_compute_instance_v2.instance[0].flavor_id
    name : openstack_compute_instance_v2.instance[0].flavor_name
  }
}

output "instance" {
  value = {
    id : openstack_compute_instance_v2.instance[*].id
    name : openstack_compute_instance_v2.instance[*].name
  }
}
