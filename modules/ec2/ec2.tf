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

    ingress {
    description      = "Allow TCP 5173"
    from_port        = 5173
    to_port          = 5173
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow TCP 5174"
    from_port        = 5174
    to_port          = 5174
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

resource "aws_eip" "ec2_eip" {
  count = var.create_eip ? 1 : 0
  vpc   = true

  tags = {
    Name = "${var.name}-eip"
  }
}

resource "aws_eip_association" "ec2_eip_assoc" {
  count         = var.create_eip ? 1 : 0
  instance_id   = aws_instance.ec2_instance.id
  allocation_id = aws_eip.ec2_eip[0].id
}

resource "aws_ebs_volume" "extra_volume" {
  availability_zone = aws_instance.ec2_instance.availability_zone
  size              = var.ebs_volume_size
  type              = var.ebs_volume_type
  tags = {
    Name = "${var.name}-extra-ebs"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.extra_volume.id
  instance_id = aws_instance.ec2_instance.id
  force_detach = true
}