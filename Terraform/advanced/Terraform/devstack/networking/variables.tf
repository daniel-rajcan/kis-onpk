# --- networking/variables.tf ---

variable "project" {
  type = string
}
variable "external_network_id" {
  type = string
}

variable "subnet_cidrs" {
  type = list(string)
}

variable "subnet_cidrs_count" {
  type = number
}
