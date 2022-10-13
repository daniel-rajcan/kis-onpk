# --- root/variables.tf ---

variable "username" {
  type = string
}
variable "password" {
  type = string
}
variable "tenant_name" {
  type = string
}

variable "project" {
  type    = string
  default = "onpk"
}
variable "environment" {
  type    = string
  default = "dev"
}
