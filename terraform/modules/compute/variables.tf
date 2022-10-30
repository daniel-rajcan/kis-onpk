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

variable "user_data" {
  type = string
}

# Default: ext-net (public network -> instance is connected to the public internet)
variable "network_name" {
  type    = string
  default = "ext-net"
}

# Default: ONPK_large
variable "flavor_id" {
  type    = string
  default = "38786c05-8577-4115-b374-0024ac93b857"
}
