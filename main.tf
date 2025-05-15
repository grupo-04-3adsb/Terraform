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
  key_name   = var.key_pair_name
  public_key = file("~/id_rsa.pem.pub")
}

module "vpc" {
  source              = "./modules/VPC"
  cidr_block          = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  name                = "Ebuy-VPC"      
}

module "ec2_public" {
  source                      = "./modules/ec2"
  ami                         = "ami-084568db4383264d4"
  instance_type               = "t2.micro"
  name                        = "Ebuy-EC2-public"
  subnet_id                   = module.vpc.public_subnet_id
  associate_public_ip_address = true
  rsa_key                     = aws_key_pair.ebuy-key.key_name
  vpc_id                      = module.vpc.vpc_id
  allowed_ssh_cidr_blocks     = ["0.0.0.0/0"]
  create_eip                  = true
}

module "ec2_private" {
  source                      = "./modules/ec2"
  ami                         = "ami-084568db4383264d4"
  instance_type               = "t2.micro"
  name                        = "Ebuy-EC2-private"
  subnet_id                   = module.vpc.private_subnet_id
  associate_public_ip_address = false
  rsa_key                     = aws_key_pair.ebuy-key.key_name
  vpc_id                      = module.vpc.vpc_id

  security_group_id           = module.ec2_public.security_group_id
}

module "ec2_private_2" {
  source                      = "./modules/ec2"
  ami                         = "ami-084568db4383264d4"
  instance_type               = "t2.micro"
  name                        = "Ebuy-EC2-private-2"
  subnet_id                   = module.vpc.private_subnet_id
  associate_public_ip_address = false
  rsa_key                     = aws_key_pair.ebuy-key.key_name
  vpc_id                      = module.vpc.vpc_id
  security_group_id           = module.ec2_public.security_group_id
}