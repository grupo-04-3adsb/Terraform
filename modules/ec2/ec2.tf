resource "aws_instance" "ec2_instance" {
  ami = var.ami
  instance_type = var.instance_type

  tags = {
    name = var.name
  }
}