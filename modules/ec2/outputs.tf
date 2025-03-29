output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2_instance.id
}

output "security_group_id" {
  description = "ID do Security Group associado à instância EC2"
  value       = aws_security_group.ec2_sg.id
}