terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  access_key = "AKIATJZ2JJVXX7ESCXJJ"
  secret_key = "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"
}

data "aws_subnet" "fithealth2pubsn" {
  cidr_block = "172.12.1.0/24"
  tags = {
    "Name" = "fithealth2pubsn"
  }
}

data "aws_vpc" "fithealth2vpc" {
    cidr_block = "172.12.0.0/16"
    tags = {
      "Name" = "fithealth2vpc"
    }
}

resource "aws_security_group" "fithealth2ec2sg" {
    vpc_id = data.aws_vpc.fithealth2vpc.id
    ingress  {
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
    tags = {
      "Name" = "fithealth2ec2sg"
    }
    description = "fithealth2 ec2 SSH public access"
}

resource "aws_key_pair" "fithealth2kp" {
  key_name = "fithealth2kp"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtR1kc0F2T2juR7GwdcOSCeRha91iwv+cSaU7HRAp+lFhgMSTOPu2fbdhvKnmTf74nbc5e1NmX3mwt+azWV7F81FP26Y+sItZqVzOFbjkRI8GXe1op6lonc7Mfjpam4Cl08iaX75lC5tzH4NzJamQ52o4LIyYL1xjRVT5zPNDuH0bcyyPqLora17Bya/QRB4wD3WNNAsWzOxIBgLF/g1Ysb7mrVrkLUDMYQWt44DM4r8J/pqZtLbrdq7rkWIppUgzZBB7UfB+/j9bVS37tNFyeLVpb1qKIqGh9jXkxczTqWe7JxO6GPyPXUYsheGaCEUoQCVfJpYfDCiWojaXiS81eFO++ciqxzg1vcX08S4N86bHzvveK6lkETQE+VbzUfiWEhbEJH9ECI3yjighICJfDsLhZt7eJUPSVhnIHQWvrvlgKP1O8q2UTAaUB15gXPQuwP6uDSHrW15X6iPWla5R5u7B/m1vyi/IEfaFtVe/eQ7haUmbXyZRStO7fVuckmDk= Sriman@DESKTOP-1QI4S5N"
}

resource "aws_instance" "fithealth2ec2" {
  subnet_id = data.aws_subnet.fithealth2pubsn.id
  instance_type = "t2.micro"
  ami = "ami-024c319d5d14b463e"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.fithealth2ec2sg.id]
  key_name = aws_key_pair.fithealth2kp.key_name
  tags = {
    "Name" = "fithealth2ec2"
  }
}
















