terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}
resource "aws_key_pair" "terraformkp" {
  key_name   = "terraformkp"
  public_key = var.ec2config.publicKey
}

resource "aws_instance" "javaserver" {
  instance_type               = var.ec2config.instanceType
  ami                         = var.ec2config.ami
  associate_public_ip_address = var.ec2config.associatePublicIpAddress
  key_name                    = aws_key_pair.terraformkp.key_name
  tags = {
    "Name" = var.ec2config.tags["Name"]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("~/.ssh/terraformkp")
  }
  provisioner "file" {
    source      = "sh/installjdk.sh"
    destination = "/tmp/installjdk.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/installjdk.sh",
      "bash /tmp/installjdk.sh"
    ]
  }
}

resource "aws_instance" "localexecec2" {
  instance_type               = var.ec2config.instanceType
  ami                         = var.ec2config.ami
  associate_public_ip_address = var.ec2config.associatePublicIpAddress
  key_name                    = aws_key_pair.terraformkp.key_name
  tags = {
    "Name" = "localexecec2"
  }
  provisioner "local-exec" {
    command = "echo $self.public_ip > hosts"
  }
}
