# --- root/main.tf ---

resource "openstack_compute_keypair_v2" "keypair" {
  name = "${var.project}-${var.environment}-keypair"
}

resource "local_file" "private_key" {
  content         = openstack_compute_keypair_v2.keypair.private_key
  filename        = "${path.module}/${openstack_compute_keypair_v2.keypair.name}.pem"
  file_permission = "0400"
}

data "http" "my_public_ip" {
  url = "http://ipv4.icanhazip.com"
}

module "instance" {
  source           = "./compute"
  project          = var.project
  environment      = var.environment
  my_public_ip     = data.http.my_public_ip.response_body
  key_pair_name    = openstack_compute_keypair_v2.keypair.name
  script_file_path = "${path.module}/scripts/docker.sh"
}
