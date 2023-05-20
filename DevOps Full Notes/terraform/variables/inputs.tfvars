vpc_cidr = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"
ec2config = {
  ami = "ami-024c319d5d14b463e"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  tags = {
    "Name" = "ec2vars"
  }
}
