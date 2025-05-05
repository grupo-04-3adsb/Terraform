variable "ami" {
  description = "The AMI to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
}

variable "name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the EC2 instance in"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = false
}

variable "rsa_key" {
  description = "The RSA key pair name to use for SSH access"
  type        = string
}

variable "vpc_id" {
  description = "O ID da VPC onde o Security Group será criado"
  type        = string
}

variable "allowed_ssh_cidr_blocks" {
  description = "Lista de blocos CIDR permitidos para acesso SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "security_group_id" {
  description = "ID de um Security Group existente para associar à instância EC2"
  type        = string
  default     = null
}

variable "ebs_volume_size" {
  description = "Tamanho do volume EBS em GB"
  type        = number
  default     = 8
}

variable "ebs_volume_type" {
  description = "Tipo do volume EBS"
  type        = string
  default     = "gp2"
}