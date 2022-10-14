# --- computing/variables.tf ---

variable "project" {
  type = string
}

variable "image_id" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "network_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}
