# --- root/outputs.tf ---

output "networking" {
  value = [for x in module.networking[*] : x]
}

output "computing" {
  value = [for x in module.computing[*] : x]
}
