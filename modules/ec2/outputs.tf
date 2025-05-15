output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2_instance.id
}

output "security_group_id" {
  description = "ID do Security Group associado à instância EC2"
  value       = aws_security_group.ec2_sg.id
}

output "public_ip" {
  value = var.create_eip ? aws_eip.ec2_eip[0].public_ip : aws_instance.ec2_instance.public_ip
  description = "O IP público da instância EC2"
}