terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  profile = "default"
  region = "ap-south-1"
}

resource "aws_key_pair" "terraformkp" {
    key_name = "terraformkp"
    public_key = var.ec2config.public_key
}

# resource "aws_instance" "tfec2" {
#   instance_type = var.ec2config.instance_type
#   ami = var.ec2config.ami
#   associate_public_ip_address = var.ec2config.associate_public_ip_address
#   key_name = aws_key_pair.terraformkp.key_name
#   vpc_security_group_ids = [aws_security_group.tfsg.id]
#   tags = {
#     "Name" = var.ec2config.instance_name
#   }
# }

resource "aws_security_group" "tfsg" {
  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}