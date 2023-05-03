output "subnet_ids_pub" {
  description = "List of IDs for the created subnets"
  value       = snet-public.public.*.id
}
output "subnet_ids_priv" {
  description = "List of IDs for the created subnets"
  value       = snet-private.public.*.id
}