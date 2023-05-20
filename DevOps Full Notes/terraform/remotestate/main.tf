terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket         = "fithealth-tfstate-bucket"
    region         = "ap-south-1"
    key            = "terraform.tfstate"
    dynamodb_table = "fithealth2-terraform-lock"
  }
}
provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}
resource "aws_key_pair" "tfremotekp" {
  key_name   = "tfremotekp"
  public_key = var.ec2config.public_key
}
resource "aws_instance" "tfremoteec2" {
  instance_type               = var.ec2config.instance_type
  ami                         = var.ec2config.ami
  key_name                    = aws_key_pair.tfremotekp.key_name
  associate_public_ip_address = var.ec2config.associate_public_ip_address
  tags = {
    "Name" = var.ec2config.instance_name
  }
}
