variable "ami" {
  description = "The AMI to use for the EC2 instance"
  type = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type = string
}

variable "name" {
  description = "The name of the EC2 instance"
  type = string
}