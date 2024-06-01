output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private.*.id
}

output "private_subnet_id" {
  value = aws_subnet.private[0].id  # Output the subnet ID of the first private subnet
}