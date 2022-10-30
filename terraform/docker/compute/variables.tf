# --- compute/variables.tf ---

variable "project" {
  type = string
}
variable "environment" {
  type = string
}

variable "my_public_ip" {
  type = string
}

variable "key_pair_name" {
  type = string
}

variable "script_file_path" {
  type = string
}

# Default: ext-net (public network -> instance is connected to the public internet)
variable "network_name" {
  type    = string
  default = "ext-net"
}

# Default: ONPK_small
variable "flavor_id" {
  type    = string
  default = "7de08105-668c-48c1-8978-5fc40f578d24"
}
