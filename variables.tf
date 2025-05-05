variable "key_pair_name" {
  type        = string
  default     = "id_rsa"  
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
