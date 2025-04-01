resource "aws_security_group" "ec2_sg" {
  name        = "${var.name}-sg"
  description = "Security Group for EC2 instance ${var.name}"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.allowed_ssh_cidr_blocks
  }

  ingress {
    description      = "Custom TCP Rule"
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-sg"
  }
}

resource "aws_instance" "ec2_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.rsa_key
  
  vpc_security_group_ids = var.security_group_id != null ? [var.security_group_id] : [aws_security_group.ec2_sg.id]

  tags = {
    Name = var.name
  }

  lifecycle {
    create_before_destroy = true
  }
}