output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.primary.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.primary.cidr_block
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.main.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs keyed by subnet name"
  value       = { for name, subnet in aws_subnet.public : name => subnet.id }
}

output "private_subnet_ids" {
  description = "Private subnet IDs keyed by subnet name"
  value       = { for name, subnet in aws_subnet.private : name => subnet.id }
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private.id
}
