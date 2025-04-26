output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
  description = "ID da sub-rede pública"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "ID da sub-rede privada"
  value       = aws_subnet.private_subnet.id
}

output "nat_gateway_id" {
  description = "ID do NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

output "internet_gateway_id" {
  description = "ID do Internet Gateway"
  value       = aws_internet_gateway.igw.id
}