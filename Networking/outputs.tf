output "subnet_ids" {
  description = "List of IDs for the created subnets"
  value       = aws_subnet.public.*.id
}