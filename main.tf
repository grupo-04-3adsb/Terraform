terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 4.16"
        }
    }
    
    required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "ebuy-key" {
  key_name   = "ebuy-rsa-key"
  public_key = "~/.ssh/ebuy_key.pub"
}

module "ec2_public" {
  source                      = "./modules/ec2"
  ami                         = "ami-0c55b159cbfafe1f0"
  instance_type               = "t2.micro"
  name                        = "Ebuy-EC2-public-ec2"
  subnet_id                   = module.vpc.public_subnet_id
  associate_public_ip_address = true
  rsa_key                     = aws_key_pair.ebuy-key.key_name
  vpc_id                      = module.vpc.vpc_id
  allowed_ssh_cidr_blocks     = ["0.0.0.0/0"]
}

module "ec2_private" {
  source                      = "./modules/ec2"
  ami                         = "ami-0c55b159cbfafe1f0"
  instance_type               = "t2.micro"
  name                        = "Ebuy-EC2-private-ec2"
  subnet_id                   = module.vpc.private_subnet_id
  associate_public_ip_address = false
  rsa_key                     = aws_key_pair.ebuy-key.key_name
  vpc_id                      = module.vpc.vpc_id

  security_group_id           = module.ec2_public.security_group_id
}