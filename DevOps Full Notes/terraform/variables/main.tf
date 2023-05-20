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

resource "aws_vpc" "varvpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "varvpc"
  }
}

resource "aws_subnet" "varpubsn" {
  vpc_id = aws_vpc.varvpc.id
  cidr_block = var.subnet_cidr
  tags = {
    "Name" = "varpubsn"
  }
}

resource "aws_internet_gateway" "varig" {
    vpc_id = aws_vpc.varvpc.id
    tags = {
      "Name" = "varig"
    }
}

resource "aws_route_table" "varigrt" {
  vpc_id = aws_vpc.varvpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.varig.id
  } 
}

resource "aws_route_table_association" "varigrtassociation" {
    route_table_id = aws_route_table.varigrt.id
    subnet_id = aws_subnet.varpubsn.id
}

resource "aws_key_pair" "varkp" {
  key_name = "varkp"
  public_key = var.public_key
}

resource "aws_security_group" "varsg" {
  vpc_id = aws_vpc.varvpc.id
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

resource "aws_instance" "varec2" {
  instance_type = var.ec2config.instance_type
  ami = var.ec2config.ami
  associate_public_ip_address = var.ec2config.associate_public_ip_address
  subnet_id = aws_subnet.varpubsn.id
  tags = {
    "Name" = var.ec2config.tags["Name"]
  }
  vpc_security_group_ids = [aws_security_group.varsg.id]
  key_name = aws_key_pair.varkp.key_name
}


























