fithealth2_vpc_cidr = "10.0.0.0/16"
fithealth2_prvsn1_cidr = "10.0.1.0/24"
fithealth2_prvsn2_cidr = "10.0.2.0/24"
fithealth2_pubsn3_cidr = "10.0.3.0/24"
sql_port = 3306
ssh_port = 22
jumpboxconfig = {
  ami = "ami-024c319d5d14b463e"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  tags = {
    "Name" = "fithealth2jumpbox"
  }
}
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtR1kc0F2T2juR7GwdcOSCeRha91iwv+cSaU7HRAp+lFhgMSTOPu2fbdhvKnmTf74nbc5e1NmX3mwt+azWV7F81FP26Y+sItZqVzOFbjkRI8GXe1op6lonc7Mfjpam4Cl08iaX75lC5tzH4NzJamQ52o4LIyYL1xjRVT5zPNDuH0bcyyPqLora17Bya/QRB4wD3WNNAsWzOxIBgLF/g1Ysb7mrVrkLUDMYQWt44DM4r8J/pqZtLbrdq7rkWIppUgzZBB7UfB+/j9bVS37tNFyeLVpb1qKIqGh9jXkxczTqWe7JxO6GPyPXUYsheGaCEUoQCVfJpYfDCiWojaXiS81eFO++ciqxzg1vcX08S4N86bHzvveK6lkETQE+VbzUfiWEhbEJH9ECI3yjighICJfDsLhZt7eJUPSVhnIHQWvrvlgKP1O8q2UTAaUB15gXPQuwP6uDSHrW15X6iPWla5R5u7B/m1vyi/IEfaFtVe/eQ7haUmbXyZRStO7fVuckmDk= Sriman@DESKTOP-1QI4S5N"
db_name="fithealth2rds"
rds_engine = "mysql"
rds_root_username = "root"
rds_password="Welcome#123"
rds_engine_version="8.0.30"
rds_instance_class = "db.t2.micro"

