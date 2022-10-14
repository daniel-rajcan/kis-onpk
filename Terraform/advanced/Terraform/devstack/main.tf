# --- root/main.tf ---

resource "null_resource" "get_ext_network_id" {
  triggers = {
    tenant_name = local.deployment.tenant_name
  }

  provisioner "local-exec" {
    command = "bash ./scripts/get_ext_network_id.sh ${var.openstack_username} ${var.openstack_password} ${var.openstack_auth_url}"
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm -f ./ext_network_id"
  }
}

data "local_file" "ext_network_id" {
  depends_on = [
    null_resource.get_ext_network_id
  ]

  filename = "${path.module}/ext_network_id"
}

resource "null_resource" "get_cirros_image_id" {
  triggers = {
    tenant_name = local.deployment.tenant_name
  }

  provisioner "local-exec" {
    command = "bash ./scripts/get_cirros_image_id.sh ${var.openstack_username} ${var.openstack_password} ${var.openstack_auth_url}"
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm -f ./cirros_image_id"
  }
}

data "local_file" "cirros_image_id" {
  depends_on = [
    null_resource.get_cirros_image_id
  ]

  filename = "${path.module}/cirros_image_id"
}

module "networking" {
  source              = "./networking"
#  external_network_id = data.local_file.ext_network_id.content
  external_network_id = data.openstack_networking_network_v2.ext_network_id.id
  project             = "tfm-${local.deployment["tenant_name"]}"
  subnet_cidrs        = [for i in range(0, 255, 1) : cidrsubnet(var.internal_network_cidr, 8, i)]
  subnet_cidrs_count  = local.deployment.instance_count
}

module "computing" {
  source         = "./computing"
  project        = "tfm-${local.deployment["tenant_name"]}"
#  image_id       = data.local_file.cirros_image_id.content
  image_id       = data.openstack_images_image_ids_v2.cirros_image_id.ids[0]
  instance_count = local.deployment.instance_count
  network_id     = module.networking.int_network.id
  subnet_ids     = module.networking.int_subnet_ids[*]
}

data "openstack_networking_network_v2" "ext_network_id" {
  name = "public"
}

output "ext_network_id" {
  value = data.openstack_networking_network_v2.ext_network_id.id
}

data "openstack_images_image_ids_v2" "cirros_image_id" {
  name_regex = "^cirros-*"
  sort = "updated_at"
}

output "image_id" {
  value = data.openstack_images_image_ids_v2.cirros_image_id.ids[0]
}
