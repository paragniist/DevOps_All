resource "aws_key_pair" "kp" {
  key_name = var.key_name
  public_key = var.public_key
}

resource "aws_instance" "ec2" {
    instance_type = var.instance_type
    ami = var.ami
    subnet_id = var.subnet_id
    associate_public_ip_address = var.associate_public_ip_address
    tags = {
        "Name" = var.instance_name
    }
    vpc_security_group_ids = [var.security_group_id]
    key_name = aws_key_pair.kp.key_name
}