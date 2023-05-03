output "subnet_id_pub" {
  description = "List of IDs for the created subnets"
  value       = aws_subnet.snet-public.id
}
output "subnet_id_priv" {
  description = "List of IDs for the created subnets"
  value       = aws_subnet.snet-private.id
}