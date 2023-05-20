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

resource "aws_vpc" "fithealth2vpc" {    
    cidr_block = var.fithealth2_vpc_cidr
    tags = {
      "Name" = "fithealth2vpc"
    }
}
resource "aws_subnet" "fithealth2prvsn1" {
  cidr_block = var.fithealth2_prvsn1_cidr
  vpc_id = aws_vpc.fithealth2vpc.id
  availability_zone = "ap-south-1a"
  tags = {
    "Name" = "fithealth2prvsn1"
  }
}
resource "aws_subnet" "fithealth2prvsn2" {
  cidr_block = var.fithealth2_prvsn2_cidr
  vpc_id = aws_vpc.fithealth2vpc.id
  availability_zone = "ap-south-1b"
  tags = {
    "Name" = "fithealth2prvsn2"
  }
}
resource "aws_subnet" "fithealth2pubsn3" {
  cidr_block = var.fithealth2_pubsn3_cidr
  vpc_id = aws_vpc.fithealth2vpc.id
  availability_zone = "ap-south-1a"
  tags = {
    "Name" = "fithealth2pubsn3"
  }
}
resource "aws_internet_gateway" "fithealth2ig" {
  vpc_id = aws_vpc.fithealth2vpc.id
  tags = {
    "Name" = "fithealth2ig"
  }
}
resource "aws_route_table" "fithealth2igrt" {
    vpc_id = aws_vpc.fithealth2vpc.id
    route {
        gateway_id = aws_internet_gateway.fithealth2ig.id
        cidr_block = "0.0.0.0/0"
    }
    tags = {
      "Name" = "fithealth2igrt"
    }
}
resource "aws_route_table_association" "fithealth2igrtassociation" {
  route_table_id = aws_route_table.fithealth2igrt.id
  subnet_id = aws_subnet.fithealth2pubsn3.id
}
resource "aws_security_group" "fithealth2jumpboxsg" {
  vpc_id = aws_vpc.fithealth2vpc.id
  ingress {
    from_port = var.ssh_port
    to_port = var.ssh_port
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
resource "aws_security_group" "fithealth2rdssg" {
  vpc_id = aws_vpc.fithealth2vpc.id
  ingress {
    from_port = var.sql_port
    to_port = var.sql_port
    protocol = "TCP"
    cidr_blocks = [var.fithealth2_vpc_cidr]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_key_pair" "fithealth2kp" {
    key_name = "fithealth2kp"
    public_key = var.public_key
}
resource "aws_instance" "fithealth2jumpbox" {
  subnet_id = aws_subnet.fithealth2pubsn3.id
  associate_public_ip_address = var.jumpboxconfig.associate_public_ip_address
  instance_type = var.jumpboxconfig.instance_type
  ami = var.jumpboxconfig.ami
  vpc_security_group_ids = [aws_security_group.fithealth2jumpboxsg.id]
  key_name = aws_key_pair.fithealth2kp.id
  tags = {
    "Name" = var.jumpboxconfig.tags["Name"]
  }
}
resource "aws_db_subnet_group" "fithealth2_db_subnet_group" {
    subnet_ids = [aws_subnet.fithealth2prvsn1.id, aws_subnet.fithealth2prvsn2.id]
    tags = {
      "Name" = "fithealth2dbsngrp"
    }
}

resource "aws_db_instance" "fithealth2rdsinstance" {
  db_subnet_group_name = aws_db_subnet_group.fithealth2_db_subnet_group.name
  allocated_storage = 10
  db_name = var.db_name
  engine = var.rds_engine
  engine_version = var.rds_engine_version
  instance_class = var.rds_instance_class
  username = var.rds_root_username
  password = var.rds_password
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.fithealth2rdssg.id]
}









































