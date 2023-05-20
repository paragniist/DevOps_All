variable "vpc_cidr" {
    type = string
    description = "vpc cidr"
    #default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type = string
  description = "subnet cidr"
  #default = "10.0.1.0/24"
}

variable "ec2config" {
  type = object({
    instance_type=string
    ami=string
    associate_public_ip_address=bool
    tags = map(string)
  })
  description = "ec2 configuration"
  #default = {
  #  ami = "ami-024c319d5d14b463e"
  #  associate_public_ip_address = true
  #  instance_type = "t2.micro"
  #  tags = {
  #    Name = "varsec2"
  #  }
  #}
}

variable "public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtR1kc0F2T2juR7GwdcOSCeRha91iwv+cSaU7HRAp+lFhgMSTOPu2fbdhvKnmTf74nbc5e1NmX3mwt+azWV7F81FP26Y+sItZqVzOFbjkRI8GXe1op6lonc7Mfjpam4Cl08iaX75lC5tzH4NzJamQ52o4LIyYL1xjRVT5zPNDuH0bcyyPqLora17Bya/QRB4wD3WNNAsWzOxIBgLF/g1Ysb7mrVrkLUDMYQWt44DM4r8J/pqZtLbrdq7rkWIppUgzZBB7UfB+/j9bVS37tNFyeLVpb1qKIqGh9jXkxczTqWe7JxO6GPyPXUYsheGaCEUoQCVfJpYfDCiWojaXiS81eFO++ciqxzg1vcX08S4N86bHzvveK6lkETQE+VbzUfiWEhbEJH9ECI3yjighICJfDsLhZt7eJUPSVhnIHQWvrvlgKP1O8q2UTAaUB15gXPQuwP6uDSHrW15X6iPWla5R5u7B/m1vyi/IEfaFtVe/eQ7haUmbXyZRStO7fVuckmDk= Sriman@DESKTOP-1QI4S5N"
}