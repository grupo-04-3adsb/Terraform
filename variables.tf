variable "public_key_path" {
  description = "Caminho para o arquivo da chave pública RSA"
  type        = string
  default     = "~/.ssh/ebuy_key.pub"
}

variable "ami" {
  description = "The AMI to use for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}
