output "subnet_id_pub" {
  description = "List of IDs for the created subnets"
  value       = aws_subnet.snet-public.id
}
output "subnet_id_priv" {
  description = "List of IDs for the created subnets"
  value       = aws_subnet.snet-private.id
}
output "vpc_id" {
  description = "List of IDs for the created subnets"
  value       = aws_vpc.vnet-nebo.id
}
output "priv_sg" {
  description = "List of IDs for the created subnets"
  value       = aws_security_group.public.id
}
output "pub_sg" {
  description = "List of IDs for the created subnets"
  value       = aws_security_group.public.id
}